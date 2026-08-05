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
  mainOptions, // Step 1: Bhav Jane, Operations, Sales, Accounts
  buySellSelection, // Step 1.5: If Bhav Jane selected -> Buy or Sell
  listening, // Step 2: Direct mic open
  processing, // Step 3: Claude API processing
  response, // Step 4: Display + TTS answer
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
  _AssistantStep _step = _AssistantStep.mainOptions;
  AiModel _selectedModel = AiModel.sales;
  String _intent = 'sell'; // 'buy' | 'sell' | 'general'
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

  // ── flow navigation ──

  void _onBhavJaneSelected() {
    setState(() {
      _selectedModel = AiModel.sales;
      _step = _AssistantStep.buySellSelection;
    });
  }

  void _onDirectModelSelected(AiModel model) {
    setState(() {
      _selectedModel = model;
      _intent = 'general';
      _step = _AssistantStep.listening;
    });
    _startListening();
  }

  void _onBuySellSelected(String intent) {
    setState(() {
      _intent = intent;
      _step = _AssistantStep.listening;
    });
    _startListening();
  }

  Future<void> _startListening() async {
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
          if (result.finalResult && _spokenText.trim().isNotEmpty) {
            _submitQuestion();
          }
        },
        localeId: 'hi_IN',
        listenFor: const Duration(seconds: 25),
        pauseFor: const Duration(seconds: 5),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
          listenMode: stt.ListenMode.dictation,
        ),
      );
    } catch (e) {
      debugPrint('Speech listen error: $e');
    }
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
      model: _selectedModel,
      intent: _intent,
      marketData: _marketData,
      isHindi: _isHindi,
    );

    setState(() {
      _aiResponse = response;
      _step = _AssistantStep.response;
    });

    // Auto-speak response
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
      _step = _AssistantStep.mainOptions;
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
        // Back button if not on main options
        if (_step != _AssistantStep.mainOptions)
          IconButton(
            onPressed: () {
              setState(() {
                _step = _AssistantStep.mainOptions;
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
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          color: Colors.grey.shade500,
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case _AssistantStep.mainOptions:
        return _MainOptionsStep(
          isHindi: _isHindi,
          onBhavJane: _onBhavJaneSelected,
          onDirectModel: _onDirectModelSelected,
        );
      case _AssistantStep.buySellSelection:
        return _BuySellSelectionStep(
          isHindi: _isHindi,
          onBuySellSelected: _onBuySellSelected,
        );
      case _AssistantStep.listening:
        return _ListeningStep(
          isHindi: _isHindi,
          model: _selectedModel,
          spokenText: _spokenText,
          pulseCtrl: _pulseCtrl,
          onRetry: _startListening,
          onSubmit: _spokenText.isNotEmpty ? _submitQuestion : null,
          onSelectQuickQuestion: (question) {
            setState(() => _spokenText = question);
            _submitQuestion();
          },
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
//  STEP 1 — Main Options
// ════════════════════════════════════════════════════

class _MainOptionsStep extends StatelessWidget {
  final bool isHindi;
  final VoidCallback onBhavJane;
  final void Function(AiModel) onDirectModel;

  const _MainOptionsStep({
    required this.isHindi,
    required this.onBhavJane,
    required this.onDirectModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('mainOptions'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'आप क्या सहायता चाहते हैं?' : 'How can we help you?',
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 14),
        // Option 1: Bhav Jane (Featured)
        _OptionCard(
          icon: '🏷️',
          titleHi: 'भाव जानें',
          titleEn: 'Know Rates',
          descHi: 'आज का भाव जानें (खरीद / बिक्री)',
          descEn: 'Check today\'s rates (Buy / Sell)',
          color: const Color(0xFFD84315),
          isFeatured: true,
          isHindi: isHindi,
          onTap: onBhavJane,
        ),
        const SizedBox(height: 12),
        Divider(color: Colors.grey.shade200, height: 1),
        const SizedBox(height: 12),
        // Direct department options
        _OptionCard(
          icon: '🏭',
          titleHi: 'ऑपरेशन',
          titleEn: 'Operations',
          descHi: 'गोदाम, स्टॉक, इनवर्ड-आउटवर्ड',
          descEn: 'Warehouse, stock, inward-outward',
          color: const Color(0xFF1565C0),
          isHindi: isHindi,
          onTap: () => onDirectModel(AiModel.operations),
        ),
        const SizedBox(height: 10),
        _OptionCard(
          icon: '📈',
          titleHi: 'सेल्स',
          titleEn: 'Sales',
          descHi: 'व्यापार, बोली, खरीद-बिक्री मदद',
          descEn: 'Trade, bidding, buy & sell help',
          color: const Color(0xFF2E7D32),
          isHindi: isHindi,
          onTap: () => onDirectModel(AiModel.sales),
        ),
        const SizedBox(height: 10),
        _OptionCard(
          icon: '💰',
          titleHi: 'अकाउंट्स',
          titleEn: 'Accounts',
          descHi: 'वॉलेट, भुगतान, सेटलमेंट',
          descEn: 'Wallet, payments, settlements',
          color: const Color(0xFFE65100),
          isHindi: isHindi,
          onTap: () => onDirectModel(AiModel.accounts),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String icon;
  final String titleHi;
  final String titleEn;
  final String descHi;
  final String descEn;
  final Color color;
  final bool isFeatured;
  final bool isHindi;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.titleHi,
    required this.titleEn,
    required this.descHi,
    required this.descEn,
    required this.color,
    this.isFeatured = false,
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
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isFeatured ? 16 : 14,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isFeatured ? color : color.withValues(alpha: 0.3),
              width: isFeatured ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
            color: isFeatured
                ? color.withValues(alpha: 0.1)
                : color.withValues(alpha: 0.05),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isFeatured ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isHindi ? titleHi : titleEn,
                          style: GoogleFonts.poppins(
                            fontSize: Adaptive.sp(15),
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        if (isFeatured) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isHindi ? 'मुख्य' : 'Popular',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
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
                color: color.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════
//  STEP 1.5 — Buy or Sell (Only when Bhav Jane tapped)
// ════════════════════════════════════════════════════

class _BuySellSelectionStep extends StatelessWidget {
  final bool isHindi;
  final void Function(String) onBuySellSelected;

  const _BuySellSelectionStep({
    required this.isHindi,
    required this.onBuySellSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('buySell'),
      children: [
        Text(
          isHindi ? 'आप क्या दर जानना चाहते हैं?' : 'Which rate do you want to ask?',
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
              child: _BuySellButton(
                icon: '🛒',
                labelHi: 'खरीदना है',
                labelEn: 'Want to Buy',
                color: const Color(0xFF1565C0),
                isHindi: isHindi,
                onTap: () => onBuySellSelected('buy'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _BuySellButton(
                icon: '📦',
                labelHi: 'बेचना है',
                labelEn: 'Want to Sell',
                color: const Color(0xFF2E7D32),
                isHindi: isHindi,
                onTap: () => onBuySellSelected('sell'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _BuySellButton extends StatelessWidget {
  final String icon;
  final String labelHi;
  final String labelEn;
  final Color color;
  final bool isHindi;
  final VoidCallback onTap;

  const _BuySellButton({
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
        padding: const EdgeInsets.symmetric(vertical: 22),
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
//  STEP 2 — Listening (Voice Input)
// ════════════════════════════════════════════════════

class _ListeningStep extends StatelessWidget {
  final bool isHindi;
  final AiModel model;
  final String spokenText;
  final AnimationController pulseCtrl;
  final VoidCallback onRetry;
  final VoidCallback? onSubmit;
  final void Function(String) onSelectQuickQuestion;

  const _ListeningStep({
    required this.isHindi,
    required this.model,
    required this.spokenText,
    required this.pulseCtrl,
    required this.onRetry,
    this.onSubmit,
    required this.onSelectQuickQuestion,
  });

  List<String> get _quickQuestions {
    switch (model) {
      case AiModel.operations:
        return [
          'गोदाम में माल इनवर्ड (Inward) कैसे कराएं?',
          'गोदाम से स्टॉक आउटवर्ड कैसे निकालें?',
          'डिजिटल गेट पास कैसे प्राप्त करें?',
        ];
      case AiModel.sales:
        return [
          'आज जौ का भाव क्या है?',
          'SBT में बोली कैसे लगाएं?',
          'मूंगफली और गेहूं का क्या भाव है?',
        ];
      case AiModel.accounts:
        return [
          'वॉलेट में पैसे कैसे जोड़ें या निकालें?',
          'सेटलमेंट का पैसा कब तक मिलेगा?',
          'BNPL लोन लिमिट कैसे देखें?',
        ];
    }
  }

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
        const SizedBox(height: 16),
        Text(
          isHindi ? '🎙️ बोलिए या सवाल चुनें...' : '🎙️ Speak or tap a question...',
          style: GoogleFonts.poppins(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.w600,
            color: ColorConstant.maingreen,
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
        const SizedBox(height: 14),
        // Predefined Quick Suggestion Chips
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            isHindi ? '💡 मुख्य सवाल (तुरंत पूछें):' : '💡 Quick Questions:',
            style: GoogleFonts.poppins(
              fontSize: Adaptive.sp(12),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _quickQuestions.map((q) {
            return ActionChip(
              avatar: const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFE65100)),
              label: Text(
                q,
                style: GoogleFonts.poppins(
                  fontSize: Adaptive.sp(12),
                  color: Colors.black87,
                ),
              ),
              backgroundColor: Colors.orange.shade50,
              side: BorderSide(color: Colors.orange.shade200),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => onSelectQuickQuestion(q),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
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
//  STEP 3 — Processing
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
//  STEP 4 — AI Response
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
