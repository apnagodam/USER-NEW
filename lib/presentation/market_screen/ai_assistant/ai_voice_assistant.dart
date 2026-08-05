import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'ai_service.dart';
import 'market_data_fetcher.dart';

// ---------- UI state enum ----------
enum _AssistantStep {
  listening, // Step 1: Direct mic open immediately
  processing, // Step 2: AI processing
  response, // Step 3: Display + Auto-TTS
}

// ---------- public entry point ----------

/// Shows the AI Voice Assistant bottom sheet.
/// Call this directly from the floating action button.
void showAiVoiceAssistant(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AiAssistantSheet(ref: ref),
  );
}

// ---------- main sheet widget ----------

class _AiAssistantSheet extends StatefulWidget {
  final WidgetRef ref;
  const _AiAssistantSheet({required this.ref});

  @override
  State<_AiAssistantSheet> createState() => _AiAssistantSheetState();
}

class _AiAssistantSheetState extends State<_AiAssistantSheet>
    with TickerProviderStateMixin {
  // ── state ──
  _AssistantStep _step = _AssistantStep.listening;
  String _spokenText = '';
  String _aiResponse = '';
  String _marketData = '';
  bool _isHindi = true;

  // ── packages ──
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _speechAvailable = false;
  bool _isSpeaking = false;
  Timer? _silenceTimer;

  // ── animation ──
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _isHindi = Get.locale?.languageCode == 'hi';
    _initSpeech();
    _initTts();
    _prefetchMarketData();

    // Directly open mic on sheet display
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startListening();
    });
  }

  @override
  void dispose() {
    _silenceTimer?.cancel();
    _pulseCtrl.dispose();
    _speech.stop();
    _tts.stop();
    super.dispose();
  }

  // ── init methods ──

  Future<void> _initSpeech() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      _speechAvailable = await _speech.initialize(
        onError: (e) => debugPrint('Speech error: $e'),
      );
    }
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('hi-IN');
    await _tts.setSpeechRate(0.46); // clear, bold speed
    await _tts.setVolume(1.0); // max volume
    await _tts.setPitch(1.15); // female/bold pitch

    try {
      final voices = await _tts.getVoices;
      if (voices != null && voices is List) {
        for (final voice in voices) {
          final name = voice['name'].toString().toLowerCase();
          final lang = voice['locale'].toString().toLowerCase();
          if ((lang.contains('hi') || lang.contains('in')) &&
              (name.contains('female') ||
                  name.contains('woman') ||
                  name.contains('hi-in-x-hie-local') ||
                  name.contains('hi-in-x-hid-local'))) {
            await _tts.setVoice({"name": voice['name'], "locale": voice['locale']});
            break;
          }
        }
      }
    } catch (_) {}

    _tts.setStartHandler(() => setState(() => _isSpeaking = true));
    _tts.setCompletionHandler(() => setState(() => _isSpeaking = false));
    _tts.setCancelHandler(() => setState(() => _isSpeaking = false));
  }

  Future<void> _prefetchMarketData() async {
    final token = widget.ref.read(sharedUtilityProvider).getToken();
    _marketData = await MarketDataFetcher.fetchLiveMarketSummary(
      authToken: token,
    );
  }

  Future<void> _startListening() async {
    _silenceTimer?.cancel();
    await _speech.stop();

    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      _showSnack(_isHindi
          ? 'माइक्रोफोन की अनुमति दें'
          : 'Please grant microphone permission');
      return;
    }

    if (!_speechAvailable) {
      _speechAvailable = await _speech.initialize(
        onError: (e) => debugPrint('Speech error: $e'),
      );
    }

    if (!_speechAvailable) {
      _showSnack(_isHindi
          ? 'माइक्रोफोन सेवा उपलब्ध नहीं है'
          : 'Microphone service unavailable');
      return;
    }

    setState(() => _spokenText = '');
    try {
      await _speech.listen(
        onResult: (result) {
          setState(() => _spokenText = result.recognizedWords);
          _silenceTimer?.cancel();

          if (result.finalResult && _spokenText.trim().isNotEmpty) {
            _submitQuestion();
          } else if (_spokenText.trim().isNotEmpty) {
            // Auto-submit after 2.0s of silence (no button tap required!)
            _silenceTimer = Timer(const Duration(milliseconds: 2000), () {
              if (_spokenText.trim().isNotEmpty && _step == _AssistantStep.listening) {
                _submitQuestion();
              }
            });
          }
        },
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
          listenMode: stt.ListenMode.dictation,
          localeId: 'hi_IN',
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      debugPrint('Speech listen error: $e');
    }
  }

  Future<void> _submitQuestion() async {
    _silenceTimer?.cancel();
    await _speech.stop();
    if (_spokenText.trim().isEmpty) {
      setState(() => _step = _AssistantStep.listening);
      return;
    }
    setState(() => _step = _AssistantStep.processing);

    // If market data not yet fetched, try again
    if (_marketData.isEmpty) {
      final token = widget.ref.read(sharedUtilityProvider).getToken();
      _marketData = await MarketDataFetcher.fetchLiveMarketSummary(
        authToken: token,
      );
    }

    final response = await AiService.askClaude(
      question: _spokenText.trim(),
      marketData: _marketData,
      isHindi: _isHindi,
    );

    if (!mounted) return;
    setState(() {
      _aiResponse = response;
      _step = _AssistantStep.response;
    });

    // Auto-speak response in loud, bold female voice
    _speakResponse(response);
  }

  Future<void> _speakResponse(String text) async {
    await _tts.stop();
    // Clean markdown formatting for clean speech synthesis
    final cleanText = text
        .replaceAll(RegExp(r'\*+'), '')
        .replaceAll(RegExp(r'#+'), '')
        .replaceAll(RegExp(r'\(|\)'), '')
        .trim();

    await _tts.speak(cleanText);
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: ColorConstant.maingreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ── UI build ──

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle bar
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          // Top Bar
          _buildTopBar(),
          const SizedBox(height: 16),
          // Step views with AnimatedSwitcher
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildCurrentStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        // Back icon if in response state
        if (_step == _AssistantStep.response) ...[
          IconButton(
            onPressed: () {
              _tts.stop();
              setState(() {
                _step = _AssistantStep.listening;
                _spokenText = '';
              });
              _startListening();
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: ColorConstant.maingreen,
          ),
          const SizedBox(width: 4),
        ],
        // Assistant Logo & Title
        Image.asset(
          ImageConstant.mainlogopng,
          width: 32,
          height: 32,
          errorBuilder: (_, __, ___) => Icon(
            Icons.eco,
            color: ColorConstant.maingreen,
            size: 32,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'भाव पूछें',
                style: GoogleFonts.poppins(
                  fontSize: Adaptive.sp(18),
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.maingreen,
                ),
              ),
              Text(
                _isHindi ? 'अपना गोदाम AI सहायक' : 'Apna Godam AI Assistant',
                style: TextStyle(
                  fontSize: Adaptive.sp(12),
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        // Close
        IconButton(
          onPressed: () {
            _tts.stop();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          color: Colors.grey.shade500,
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case _AssistantStep.listening:
        return _ListeningStep(
          isHindi: _isHindi,
          spokenText: _spokenText,
          pulseCtrl: _pulseCtrl,
          onRetry: _startListening,
        );
      case _AssistantStep.processing:
        return _ProcessingStep(isHindi: _isHindi);
      case _AssistantStep.response:
        return _ResponseStep(
          isHindi: _isHindi,
          response: _aiResponse,
          isSpeaking: _isSpeaking,
          onToggleSpeech: () {
            if (_isSpeaking) {
              _tts.stop();
            } else {
              _speakResponse(_aiResponse);
            }
          },
          onAskAgain: () {
            _tts.stop();
            setState(() {
              _spokenText = '';
              _step = _AssistantStep.listening;
            });
            _startListening();
          },
        );
    }
  }
}

// ════════════════════════════════════════════════════
//  STEP 1 — Listening (Direct Mic Open)
// ════════════════════════════════════════════════════

class _ListeningStep extends StatelessWidget {
  final bool isHindi;
  final String spokenText;
  final AnimationController pulseCtrl;
  final VoidCallback onRetry;

  const _ListeningStep({
    required this.isHindi,
    required this.spokenText,
    required this.pulseCtrl,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('listening'),
      children: [
        const SizedBox(height: 8),
        // Mic pulse animation — custom ripple using AnimatedBuilder
        AnimatedBuilder(
          animation: pulseCtrl,
          builder: (context, child) {
            final scale = 1.0 + pulseCtrl.value * 0.35;
            return Stack(
              alignment: Alignment.center,
              children: [
                // outer ripple
                Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.maingreen
                          .withValues(alpha: (1 - pulseCtrl.value) * 0.25),
                    ),
                  ),
                ),
                // mid ripple
                Transform.scale(
                  scale: 1.0 + pulseCtrl.value * 0.18,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.maingreen
                          .withValues(alpha: (1 - pulseCtrl.value) * 0.15),
                    ),
                  ),
                ),
                // mic button (tap to restart listening)
                GestureDetector(
                  onTap: onRetry,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ColorConstant.maingreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorConstant.maingreen.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 36),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          isHindi ? '🎙️ बोलिए...' : '🎙️ Speak now...',
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.w600,
            color: ColorConstant.maingreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isHindi
              ? 'बोलने के 2 सेकंड बाद उत्तर अपने आप आ जाएगा'
              : 'Answer will automatically appear 2 sec after speaking',
          style: TextStyle(
            fontSize: Adaptive.sp(12),
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 16),
        // Live transcription container (always visible)
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: spokenText.isNotEmpty
                ? Colors.green.shade50
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: spokenText.isNotEmpty
                  ? ColorConstant.maingreen
                  : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                spokenText.isNotEmpty ? Icons.record_voice_over : Icons.mic_none_rounded,
                color: spokenText.isNotEmpty
                    ? ColorConstant.maingreen
                    : Colors.grey.shade400,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  spokenText.isNotEmpty
                      ? spokenText
                      : (isHindi
                          ? 'आप जो बोल रहे हैं वह यहाँ दिखेगा...'
                          : 'What you speak will appear here...'),
                  style: GoogleFonts.poppins(
                    fontSize: Adaptive.sp(14),
                    fontWeight: spokenText.isNotEmpty
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: spokenText.isNotEmpty
                        ? Colors.black87
                        : Colors.grey.shade500,
                    fontStyle: spokenText.isNotEmpty
                        ? FontStyle.normal
                        : FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 2 — Processing State
// ════════════════════════════════════════════════════

class _ProcessingStep extends StatelessWidget {
  final bool isHindi;

  const _ProcessingStep({required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('processing'),
      children: [
        const SizedBox(height: 24),
        CircularProgressIndicator(
          color: ColorConstant.maingreen,
          strokeWidth: 3,
        ),
        const SizedBox(height: 20),
        Text(
          isHindi ? 'उत्तर तैयार हो रहा है...' : 'Processing answer...',
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.w600,
            color: ColorConstant.maingreen,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 3 — Response Display + Auto-TTS
// ════════════════════════════════════════════════════

class _ResponseStep extends StatelessWidget {
  final bool isHindi;
  final String response;
  final bool isSpeaking;
  final VoidCallback onToggleSpeech;
  final VoidCallback onAskAgain;

  const _ResponseStep({
    required this.isHindi,
    required this.response,
    required this.isSpeaking,
    required this.onToggleSpeech,
    required this.onAskAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('response'),
      children: [
        // AI Response Card
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 280),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: SingleChildScrollView(
            child: Text(
              response,
              style: GoogleFonts.poppins(
                fontSize: Adaptive.sp(14),
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Controls: Listen / Speak Again
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onToggleSpeech,
                icon: Icon(
                  isSpeaking
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded,
                ),
                label: Text(
                  isSpeaking
                      ? (isHindi ? 'रुकें' : 'Stop')
                      : (isHindi ? 'सुनें' : 'Listen'),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstant.maingreen,
                  side: BorderSide(color: ColorConstant.maingreen),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAskAgain,
                icon: const Icon(Icons.mic_rounded),
                label: Text(isHindi ? 'और पूछें' : 'Ask Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
