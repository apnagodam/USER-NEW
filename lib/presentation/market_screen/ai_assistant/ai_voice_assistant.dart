import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'ai_service.dart';
import 'hugging_face_service.dart';
import 'market_data_fetcher.dart';

// ---------- Chat Message Model ----------
class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final LanguageDetectionResult? language;

  _ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.language,
  });
}

// ---------- Entry Point ----------
void showAiVoiceAssistant(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AiAssistantSheet(ref: ref),
  );
}

// ---------- Main Sheet Widget ----------
class _AiAssistantSheet extends StatefulWidget {
  final WidgetRef ref;
  const _AiAssistantSheet({required this.ref});

  @override
  State<_AiAssistantSheet> createState() => _AiAssistantSheetState();
}

class _AiAssistantSheetState extends State<_AiAssistantSheet>
    with TickerProviderStateMixin {
  // ── Chat State ──
  final List<_ChatMessage> _messages = [];
  final List<Map<String, String>> _chatHistory = [];
  final ScrollController _scrollCtrl = ScrollController();
  final TextEditingController _textCtrl = TextEditingController();

  // ── Voice & Engine State ──
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _isHindi = true;
  bool _speechAvailable = false;
  bool _isListening = false;
  bool _isProcessing = false;
  bool _isSpeaking = false;
  bool _autoVoiceChat = true;

  String _spokenText = '';
  String _marketData = '';
  Timer? _silenceTimer;

  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _initTts();
    _prefetchMarketData();

    // Welcome Greeting Message
    _messages.add(_ChatMessage(
      text: 'राम-राम सा! मैं अपना गोदाम AI असिस्टेंट हूँ। आप मारवाड़ी, शेखावाटी या हिंदी में कोई भी सवाल पूछ सकते हैं।',
      isUser: false,
      timestamp: DateTime.now(),
    ));

    // Request permissions & start mic after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initAndStartListening();
      }
    });
  }

  @override
  void dispose() {
    _silenceTimer?.cancel();
    _pulseCtrl.dispose();
    _scrollCtrl.dispose();
    _textCtrl.dispose();
    try {
      _speech.cancel();
      _speech.stop();
      _tts.stop();
    } catch (_) {}
    super.dispose();
  }

  // ── Init TTS ──
  Future<void> _initTts() async {
    try {
      await _tts.setLanguage('hi-IN');
      await _tts.setSpeechRate(0.48);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.1);

      _tts.setStartHandler(() {
        if (mounted) setState(() => _isSpeaking = true);
      });
      _tts.setCompletionHandler(() {
        if (mounted) {
          setState(() => _isSpeaking = false);
          if (_autoVoiceChat) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && _autoVoiceChat && !_isListening && !_isProcessing) {
                _startListening();
              }
            });
          }
        }
      });
      _tts.setCancelHandler(() {
        if (mounted) setState(() => _isSpeaking = false);
      });
    } catch (e) {
      debugPrint('TTS Init Error: $e');
    }
  }

  Future<void> _prefetchMarketData() async {
    try {
      final token = widget.ref.read(sharedUtilityProvider).getToken();
      _marketData = await MarketDataFetcher.fetchLiveMarketSummary(
        authToken: token,
      );
    } catch (_) {}
  }

  // ── Init & Listen ──
  Future<void> _initAndStartListening() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) {
        _showSnack(_isHindi ? 'कृपया माइक्रोफोन अनुमति दें' : 'Please allow microphone access');
      }
      return;
    }

    try {
      _speechAvailable = await _speech.initialize(
        onError: (e) {
          debugPrint('Speech Error: $e');
          if (mounted) setState(() => _isListening = false);
        },
        onStatus: (s) {
          debugPrint('Speech Status: $s');
          if (mounted) {
            if (s == 'listening') {
              setState(() => _isListening = true);
            } else if (s == 'notListening' || s == 'done') {
              setState(() => _isListening = false);
            }
          }
        },
      );
    } catch (e) {
      debugPrint('STT Init Exception: $e');
    }

    if (mounted) {
      _startListening();
    }
  }

  Future<void> _startListening() async {
    _silenceTimer?.cancel();
    try {
      await _speech.cancel();
      await _speech.stop();
    } catch (_) {}

    if (!mounted) return;

    if (!_speechAvailable) {
      _speechAvailable = await _speech.initialize(
        onError: (e) => debugPrint('STT Error: $e'),
        onStatus: (s) => debugPrint('STT Status: $s'),
      );
    }

    setState(() {
      _spokenText = '';
      _textCtrl.clear();
      _isListening = true;
    });

    // Force hi_IN Devanagari Hindi/Marwari speech output
    String targetLocale = 'hi_IN';
    try {
      final systemLocales = await _speech.locales();
      for (final l in systemLocales) {
        final locId = l.localeId.toLowerCase();
        if (locId == 'hi_in' || locId == 'hi-in' || locId.startsWith('hi')) {
          targetLocale = l.localeId;
          break;
        }
      }
    } catch (_) {}

    try {
      await _speech.listen(
        onResult: (result) {
          final words = result.recognizedWords;
          if (mounted) {
            setState(() {
              _spokenText = words;
              _textCtrl.text = words;
              _textCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: words.length),
              );
            });
          }
          _silenceTimer?.cancel();

          if (result.finalResult && words.trim().isNotEmpty) {
            _submitMessage(words.trim());
          } else if (words.trim().isNotEmpty) {
            _silenceTimer = Timer(const Duration(milliseconds: 1400), () {
              if (mounted && _spokenText.trim().isNotEmpty && !_isProcessing) {
                _submitMessage(_spokenText.trim());
              }
            });
          }
        },
        localeId: targetLocale,
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
        ),
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 4),
      );
    } catch (e) {
      debugPrint('Speech Listen Error: $e');
      if (mounted) setState(() => _isListening = false);
    }
  }

  Future<void> _stopListening() async {
    _silenceTimer?.cancel();
    try {
      await _speech.stop();
    } catch (_) {}
    if (mounted) setState(() => _isListening = false);
  }

  String _lastSubmittedText = '';
  DateTime? _lastSubmittedTime;

  // ── Send Message & Get AI Reply ──
  Future<void> _submitMessage(String userText) async {
    final text = userText.trim();
    if (text.isEmpty || _isProcessing) return;

    // Deduplication check: ignore duplicate text within 2.5 seconds
    final now = DateTime.now();
    if (_lastSubmittedText == text &&
        _lastSubmittedTime != null &&
        now.difference(_lastSubmittedTime!).inMilliseconds < 2500) {
      return;
    }

    _lastSubmittedText = text;
    _lastSubmittedTime = now;

    _silenceTimer?.cancel();
    _stopListening();
    try {
      await _tts.stop();
    } catch (_) {}

    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _spokenText = '';
      _textCtrl.clear();
      _isProcessing = true;
    });

    _scrollToBottom();

    // Fetch market data if not ready
    if (_marketData.isEmpty) {
      final token = widget.ref.read(sharedUtilityProvider).getToken();
      _marketData = await MarketDataFetcher.fetchLiveMarketSummary(
        authToken: token,
      );
    }

    // Language Detection via Hugging Face API (Instant local pattern matching)
    final langResult = await HuggingFaceService.detectLanguageAndDialect(text: text);
    final isEnglish = langResult.languageCode == 'en';

    // Get Response from AI Engine with ultra-fast 750ms response timeout
    String aiReply;
    try {
      aiReply = await AiService.askClaude(
        question: text,
        marketData: _marketData,
        history: _chatHistory,
        isHindi: !isEnglish,
      ).timeout(const Duration(milliseconds: 750));
    } catch (_) {
      // Instant local Marwari dialect response fallback (<50ms response time)
      aiReply = AiService.fallbackMarketResponse(text, _marketData, history: _chatHistory);
    }

    // Save in chat history memory
    _chatHistory.add({'user': text});
    _chatHistory.add({'assistant': aiReply});

    if (!mounted) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: aiReply,
        isUser: false,
        timestamp: DateTime.now(),
        language: langResult,
      ));
      _isProcessing = false;
    });

    _scrollToBottom();

    // Speak AI response
    _speakText(aiReply, isEnglish: isEnglish);
  }

  Future<void> _speakText(String text, {bool isEnglish = false}) async {
    try {
      await _tts.stop();
      await _tts.setLanguage(isEnglish ? 'en-IN' : 'hi-IN');
      final cleanText = text
          .replaceAll(RegExp(r'\*+'), '')
          .replaceAll(RegExp(r'#+'), '')
          .replaceAll(RegExp(r'\(|\)'), '')
          .trim();
      await _tts.speak(cleanText);
    } catch (_) {}
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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

  // ── Main UI Layout ──
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFFAFAFAF), // Soft neutral background for chat
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildChatStream()),
          if (_isProcessing) _buildProcessingIndicator(),
          _buildQuickSuggestions(),
          _buildBottomControlBar(),
        ],
      ),
    );
  }

  // ── Top Header ──
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstant.maingreen,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'अपना गोदाम AI वॉइस चैट',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: Adaptive.sp(15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Hugging Face AI active • 8 भाषाएँ (मारवाड़ी, भोजपुरी...)',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: Adaptive.sp(11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Auto voice chat toggle
          IconButton(
            onPressed: () {
              setState(() => _autoVoiceChat = !_autoVoiceChat);
              _showSnack(_autoVoiceChat
                  ? '🎙️ ऑटो वॉइस मोड ऑन है'
                  : '🔇 ऑटो वॉइस मोड बंद है');
            },
            icon: Icon(
              _autoVoiceChat
                  ? Icons.graphic_eq_rounded
                  : Icons.voice_over_off_rounded,
              color: _autoVoiceChat ? Colors.greenAccent : Colors.white60,
            ),
            tooltip: 'Continuous Voice Chat',
          ),
          // Close
          IconButton(
            onPressed: () {
              _tts.stop();
              _speech.stop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ── Chat Stream (Sender & Receiver Bubbles) ──
  Widget _buildChatStream() {
    return ListView.builder(
      controller: _scrollCtrl,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        return msg.isUser ? _buildUserBubble(msg) : _buildAiBubble(msg);
      },
    );
  }

  // Sender (User) Bubble — Right Aligned
  Widget _buildUserBubble(_ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: ColorConstant.maingreen,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg.text,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: Adaptive.sp(14),
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mic_rounded, size: 12, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(msg.timestamp),
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: ColorConstant.maingreen.withValues(alpha: 0.8),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  // Receiver (AI) Bubble — Left Aligned
  Widget _buildAiBubble(_ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.amber.shade700,
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language & Hugging Face Badge
                  if (msg.language != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.amber.shade400),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🤗 ', style: TextStyle(fontSize: 12)),
                          Text(
                            'Hugging Face AI: ${msg.language!.languageName}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Response Text
                  Text(
                    msg.text,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: Adaptive.sp(14),
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Controls Wrap (Audio Listen + Direct IVR Call + Time)
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_isSpeaking) {
                            _tts.stop();
                          } else {
                            _speakText(msg.text);
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: ColorConstant.maingreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ColorConstant.maingreen),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isSpeaking ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                                size: 15,
                                color: ColorConstant.maingreen,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isSpeaking ? 'रुकें' : 'सुनें',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => CallLaunch('tel:+917733901154'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange.shade400),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_in_talk_rounded, size: 13, color: Colors.deepOrange),
                              const SizedBox(width: 4),
                              Text(
                                'IVR (7733901154)',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(msg.timestamp),
                        style: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Processing Indicator Bubble
  Widget _buildProcessingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: ColorConstant.maingreen,
            child: const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Hugging Face AI सोच रहा है...',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick Suggestions Pills ──
  Widget _buildQuickSuggestions() {
    final suggestions = [
      '🌾 जौ का भाव क्या है?',
      '📋 कांटा पर्ची क्या है?',
      '👤 कांटा मैन का कार्य क्या है?',
      '📦 माल जमा (Inward) कैसे करें?',
      '📑 गेटपास कैसे बनाएं?',
    ];

    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final s = suggestions[index];
          return ActionChip(
            label: Text(s),
            labelStyle: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Colors.green.shade900,
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Colors.green.shade300),
            ),
            onPressed: () => _submitMessage(s.replaceAll(RegExp(r'^[^\s]+\s*'), '')),
          );
        },
      ),
    );
  }

  // ── Bottom Voice Control Bar & Mic Button ──
  Widget _buildBottomControlBar() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Voice status bar / Live spoken preview
            if (_isListening || _spokenText.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mic, color: Colors.red.shade700, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _spokenText.isNotEmpty
                            ? '"$_spokenText"'
                            : 'बोलिए... (Listening to your voice)',
                        style: GoogleFonts.poppins(
                          color: Colors.red.shade900,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // Text Input Box + Big Pulsing Mic Button + Send Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _textCtrl,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: _isHindi ? 'बोलें या टाइप करें...' : 'Speak or type...',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade500),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onSubmitted: (val) => _submitMessage(val),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Pulsing Mic Button
                AnimatedBuilder(
                  animation: _pulseCtrl,
                  builder: (context, child) {
                    final scale = _isListening ? 1.0 + (_pulseCtrl.value * 0.18) : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: InkWell(
                        onTap: () {
                          if (_isListening) {
                            _stopListening();
                          } else {
                            _startListening();
                          }
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isListening ? Colors.redAccent : ColorConstant.maingreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (_isListening ? Colors.redAccent : ColorConstant.maingreen)
                                    .withValues(alpha: 0.4),
                                blurRadius: _isListening ? 12 : 6,
                                spreadRadius: _isListening ? 4 : 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 6),
                // Send Button
                IconButton(
                  onPressed: () {
                    if (_textCtrl.text.trim().isNotEmpty) {
                      _submitMessage(_textCtrl.text.trim());
                    }
                  },
                  icon: const Icon(Icons.send_rounded),
                  color: ColorConstant.maingreen,
                  iconSize: 26,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
