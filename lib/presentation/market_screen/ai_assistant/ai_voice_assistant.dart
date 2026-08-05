import 'dart:async';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/presentation/market_screen/ai_assistant/ai_service.dart';
import 'package:apnagodam/presentation/market_screen/ai_assistant/market_data_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// ---------- UI state enum ----------
enum _AssistantStep {
  modelSelection,
  intentSelection,
  listening,
  processing,
  response,
}

// ---------- public entry point ----------

/// Shows the AI Voice Assistant bottom sheet.
/// Call this from the floating action button.
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
  _AssistantStep _step = _AssistantStep.modelSelection;
  AiModel? _selectedModel;
  String _intent = 'sell'; // 'buy' | 'sell'
  String _spokenText = '';
  String _aiResponse = '';
  String _marketData = '';
  bool _isHindi = true;

  // ── packages ──
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _speechAvailable = false;
  bool _isSpeaking = false;

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
  }

  @override
  void dispose() {
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
    await _tts.setLanguage(_isHindi ? 'hi-IN' : 'en-IN');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
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

  // ── step navigation ──

  void _onModelSelected(AiModel model) {
    setState(() {
      _selectedModel = model;
      _step = _AssistantStep.intentSelection;
    });
  }

  void _onIntentSelected(String intent) {
    setState(() {
      _intent = intent;
      _step = _AssistantStep.listening;
    });
    _startListening();
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      _showSnack(_isHindi
          ? 'माइक्रोफोन उपलब्ध नहीं है'
          : 'Microphone not available');
      return;
    }
    setState(() => _spokenText = '');
    await _speech.listen(
      onResult: (result) {
        setState(() => _spokenText = result.recognizedWords);
        if (result.finalResult && _spokenText.isNotEmpty) {
          _submitQuestion();
        }
      },
      localeId: _isHindi ? 'hi_IN' : 'en_IN',
      listenFor: const Duration(seconds: 20),
      pauseFor: const Duration(seconds: 4),
      listenOptions: stt.SpeechListenOptions(cancelOnError: true),
    );
  }

  Future<void> _submitQuestion() async {
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
      question: _spokenText,
      model: _selectedModel!,
      intent: _intent,
      marketData: _marketData,
      isHindi: _isHindi,
    );

    setState(() {
      _aiResponse = response;
      _step = _AssistantStep.response;
    });

    // Auto-speak the response
    await _speak(response);
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking) {
      await _tts.stop();
    } else {
      await _tts.speak(text);
    }
  }

  void _resetToStart() {
    _tts.stop();
    setState(() {
      _step = _AssistantStep.modelSelection;
      _selectedModel = null;
      _spokenText = '';
      _aiResponse = '';
    });
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  // ── build ──

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // header
              _buildHeader(),
              const SizedBox(height: 20),
              // step content
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: _buildCurrentStep(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Back button (except on first step)
        if (_step != _AssistantStep.modelSelection)
          IconButton(
            onPressed: () {
              setState(() {
                _step = _step == _AssistantStep.intentSelection
                    ? _AssistantStep.modelSelection
                    : _AssistantStep.intentSelection;
                _speech.stop();
              });
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            color: ColorConstant.maingreen,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isHindi ? '🌾 भाव पूछें' : '🌾 Ask Rates',
                style: GoogleFonts.poppins(
                  fontSize: Adaptive.sp(18),
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.maingreen,
                ),
              ),
              Text(
                _isHindi
                    ? 'अपना गोदाम AI सहायक'
                    : 'Apna Godam AI Assistant',
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
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          color: Colors.grey.shade500,
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case _AssistantStep.modelSelection:
        return _ModelSelectionStep(
          isHindi: _isHindi,
          onModelSelected: _onModelSelected,
        );
      case _AssistantStep.intentSelection:
        return _IntentSelectionStep(
          isHindi: _isHindi,
          model: _selectedModel!,
          onIntentSelected: _onIntentSelected,
        );
      case _AssistantStep.listening:
        return _ListeningStep(
          isHindi: _isHindi,
          spokenText: _spokenText,
          pulseCtrl: _pulseCtrl,
          onRetry: _startListening,
          onSubmit: _spokenText.isNotEmpty ? _submitQuestion : null,
        );
      case _AssistantStep.processing:
        return _ProcessingStep(isHindi: _isHindi);
      case _AssistantStep.response:
        return _ResponseStep(
          isHindi: _isHindi,
          question: _spokenText,
          response: _aiResponse,
          isSpeaking: _isSpeaking,
          onSpeak: () => _speak(_aiResponse),
          onAskAgain: _resetToStart,
        );
    }
  }
}

// ════════════════════════════════════════════════════
//  STEP 1 — Model Selection
// ════════════════════════════════════════════════════

class _ModelSelectionStep extends StatelessWidget {
  final bool isHindi;
  final void Function(AiModel) onModelSelected;

  const _ModelSelectionStep({
    required this.isHindi,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('model'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'विभाग चुनें:' : 'Select Department:',
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 14),
        _ModelCard(
          icon: '🏭',
          titleHi: 'ऑपरेशन',
          titleEn: 'Operations',
          descHi: 'गोदाम, स्टॉक, इनवर्ड-आउटवर्ड',
          descEn: 'Warehouse, stock, inward-outward',
          color: const Color(0xFF1565C0),
          isHindi: isHindi,
          onTap: () => onModelSelected(AiModel.operations),
        ),
        const SizedBox(height: 10),
        _ModelCard(
          icon: '📈',
          titleHi: 'सेल्स',
          titleEn: 'Sales',
          descHi: 'बाजार भाव, खरीद-बिक्री दरें',
          descEn: 'Market rates, buy & sell prices',
          color: const Color(0xFF2E7D32),
          isHindi: isHindi,
          onTap: () => onModelSelected(AiModel.sales),
        ),
        const SizedBox(height: 10),
        _ModelCard(
          icon: '💰',
          titleHi: 'अकाउंट्स',
          titleEn: 'Accounts',
          descHi: 'वॉलेट, भुगतान, सेटलमेंट',
          descEn: 'Wallet, payments, settlements',
          color: const Color(0xFFE65100),
          isHindi: isHindi,
          onTap: () => onModelSelected(AiModel.accounts),
        ),
      ],
    );
  }
}

class _ModelCard extends StatelessWidget {
  final String icon;
  final String titleHi;
  final String titleEn;
  final String descHi;
  final String descEn;
  final Color color;
  final bool isHindi;
  final VoidCallback onTap;

  const _ModelCard({
    required this.icon,
    required this.titleHi,
    required this.titleEn,
    required this.descHi,
    required this.descEn,
    required this.color,
    required this.isHindi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(16),
            color: color.withValues(alpha: 0.05),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? titleHi : titleEn,
                      style: GoogleFonts.poppins(
                        fontSize: Adaptive.sp(15),
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    Text(
                      isHindi ? descHi : descEn,
                      style: TextStyle(
                        fontSize: Adaptive.sp(12),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: color.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 2 — Intent Selection (Buy / Sell)
// ════════════════════════════════════════════════════

class _IntentSelectionStep extends StatelessWidget {
  final bool isHindi;
  final AiModel model;
  final void Function(String) onIntentSelected;

  const _IntentSelectionStep({
    required this.isHindi,
    required this.model,
    required this.onIntentSelected,
  });

  @override
  Widget build(BuildContext context) {
    String modelName;
    switch (model) {
      case AiModel.operations:
        modelName = isHindi ? 'ऑपरेशन' : 'Operations';
        break;
      case AiModel.sales:
        modelName = isHindi ? 'सेल्स' : 'Sales';
        break;
      case AiModel.accounts:
        modelName = isHindi ? 'अकाउंट्स' : 'Accounts';
        break;
    }

    return Column(
      key: const ValueKey('intent'),
      children: [
        Text(
          isHindi
              ? '$modelName विभाग चुना\nआप क्या करना चाहते हैं?'
              : '$modelName selected\nWhat would you like to do?',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _IntentButton(
                icon: '🛒',
                labelHi: 'खरीदना है',
                labelEn: 'I want to Buy',
                color: const Color(0xFF1565C0),
                isHindi: isHindi,
                onTap: () => onIntentSelected('buy'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _IntentButton(
                icon: '📦',
                labelHi: 'बेचना है',
                labelEn: 'I want to Sell',
                color: const Color(0xFF2E7D32),
                isHindi: isHindi,
                onTap: () => onIntentSelected('sell'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _IntentButton extends StatelessWidget {
  final String icon;
  final String labelHi;
  final String labelEn;
  final Color color;
  final bool isHindi;
  final VoidCallback onTap;

  const _IntentButton({
    required this.icon,
    required this.labelHi,
    required this.labelEn,
    required this.color,
    required this.isHindi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(
              isHindi ? labelHi : labelEn,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: Adaptive.sp(14),
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 3 — Listening (Voice Input)
// ════════════════════════════════════════════════════

class _ListeningStep extends StatelessWidget {
  final bool isHindi;
  final String spokenText;
  final AnimationController pulseCtrl;
  final VoidCallback onRetry;
  final VoidCallback? onSubmit;

  const _ListeningStep({
    required this.isHindi,
    required this.spokenText,
    required this.pulseCtrl,
    required this.onRetry,
    this.onSubmit,
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
                // mic button
                Container(
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
              ],
            );
          },
        ),
        const SizedBox(height: 20),
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
              ? 'उदाहरण: "आज जौ का क्या भाव है?"'
              : 'Example: "What is today\'s barley rate?"',
          style: TextStyle(
            fontSize: Adaptive.sp(12),
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 20),
        // Live transcription box
        if (spokenText.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              '"$spokenText"',
              style: GoogleFonts.poppins(
                fontSize: Adaptive.sp(14),
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(isHindi ? 'फिर से' : 'Retry'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorConstant.maingreen,
                side: BorderSide(color: ColorConstant.maingreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (onSubmit != null) ...[
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.send_rounded),
                label: Text(isHindi ? 'भेजें' : 'Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 4 — Processing
// ════════════════════════════════════════════════════

class _ProcessingStep extends StatelessWidget {
  final bool isHindi;
  const _ProcessingStep({required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('processing'),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: ColorConstant.maingreen,
            strokeWidth: 3,
          ),
          const SizedBox(height: 20),
          Text(
            isHindi
                ? '⏳ AI जवाब तैयार कर रहा है...'
                : '⏳ AI is preparing your answer...',
            style: GoogleFonts.poppins(
              fontSize: Adaptive.sp(14),
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isHindi ? 'बाजार डेटा देख रहे हैं' : 'Checking live market data',
            style: TextStyle(
              fontSize: Adaptive.sp(12),
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 5 — AI Response
// ════════════════════════════════════════════════════

class _ResponseStep extends StatelessWidget {
  final bool isHindi;
  final String question;
  final String response;
  final bool isSpeaking;
  final VoidCallback onSpeak;
  final VoidCallback onAskAgain;

  const _ResponseStep({
    required this.isHindi,
    required this.question,
    required this.response,
    required this.isSpeaking,
    required this.onSpeak,
    required this.onAskAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('response'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question bubble
        if (question.isNotEmpty) ...[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstant.maingreen,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                '"$question"',
                style: GoogleFonts.poppins(
                  fontSize: Adaptive.sp(13),
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        // AI response bubble
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(
                child: Text('🤖', style: TextStyle(fontSize: Adaptive.sp(16))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
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
          ],
        ),
        const SizedBox(height: 20),
        // Action buttons
        Row(
          children: [
            // Speak / Stop
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSpeak,
                icon: Icon(
                  isSpeaking ? Icons.stop_circle_rounded : Icons.volume_up_rounded,
                ),
                label: Text(
                  isSpeaking
                      ? (isHindi ? 'रोकें' : 'Stop')
                      : (isHindi ? 'सुनें' : 'Listen'),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstant.maingreen,
                  side: BorderSide(color: ColorConstant.maingreen),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Ask again
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAskAgain,
                icon: const Icon(Icons.mic_rounded),
                label: Text(isHindi ? 'और पूछें' : 'Ask More'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
