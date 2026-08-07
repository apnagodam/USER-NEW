import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';

/// Language and Dialect Detection Result Model
class LanguageDetectionResult {
  final String languageCode; // e.g., 'mwr', 'shk', 'raj', 'hi', 'en'
  final String languageName; // e.g., 'Marwari (मारवाड़ी)', 'Shekhawati (शेखावाटी)', 'Rajasthani (राजस्थानी)', 'Hindi (हिंदी)', 'English'
  final double confidence; // e.g., 0.95
  final bool isRegionalDialect; // true for Marwari, Shekhawati, Rajasthani
  final String normalizedText; // Normalized standard Hindi/English text for query processing

  LanguageDetectionResult({
    required this.languageCode,
    required this.languageName,
    required this.confidence,
    required this.isRegionalDialect,
    required this.normalizedText,
  });

  Map<String, dynamic> toJson() => {
        'languageCode': languageCode,
        'languageName': languageName,
        'confidence': confidence,
        'isRegionalDialect': isRegionalDialect,
        'normalizedText': normalizedText,
      };
}

/// Dedicated Hugging Face AI Service for Language Detection & Marwari/Shekhawati AI Inference
class HuggingFaceService {
  // Primary Hugging Face Router / Inference API Endpoints
  static const String _hfBaseUrl = 'https://router.huggingface.co/hf-inference/v1/chat/completions';
  static const String _hfTextClassifyUrl = 'https://api-inference.huggingface.co/models/facebook/mms-lid-256';
  static const String _hfAsrUrl = 'https://api-inference.huggingface.co/models/ai4bharat/indicwav2vec-v1-mwr';

  /// Detects whether the input text is in Marwari, Shekhawati, Rajasthani, Hindi, or English
  /// using a combination of Hugging Face Inference API and Regional Lexicon Pattern Matching.
  static Future<LanguageDetectionResult> detectLanguageAndDialect({
    required String text,
    String? apiKeyOverride,
  }) async {
    final rawText = text.trim();
    final lowerText = rawText.toLowerCase();

    if (rawText.isEmpty) {
      return LanguageDetectionResult(
        languageCode: 'hi',
        languageName: 'Hindi (हिंदी)',
        confidence: 1.0,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    // 1. Marwari & Shekhawati Regional Dialect Lexicon & Grammar Markers
    final marwariKeywords = [
      'रो', 'रा', 'री', 'कांई', 'ाईं', 'म्हाने', 'म्हाका', 'थै', 'थारो', 'थांरो',
      'किया', 'कतरा', 'कठै', 'अठै', 'बठै', 'कोण्या', 'कोइनी', 'छै', 'छै।', 'होवै',
      'लागैगा', 'लागसी', 'कराणो', 'बेचणी', 'खरीदणी', 'बोली', 'चिठ्ठो', 'बाजरी',
      'गैहूं', 'सरसो', 'मोठ', 'मंगफली', 'गवार'
    ];

    final shekhawatiKeywords = [
      'कोणी', 'कठै', 'अठै', 'बठै', 'कतरया', 'कतरै', 'कियाकर', 'सुणाओ', 'सुणो',
      'कांईयां', 'कियांस्यूं', 'पिया', 'रुपया', 'गोदामूं', 'मंडीस्यूं', 'भावड़ा'
    ];

    int marwariScore = 0;
    int shekhawatiScore = 0;

    for (final kw in marwariKeywords) {
      if (rawText.contains(kw)) marwariScore++;
    }

    for (final kw in shekhawatiKeywords) {
      if (rawText.contains(kw)) shekhawatiScore++;
    }

    // 2. Query Hugging Face Language Detection Model (if API Key Available)
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isNotEmpty && apiKey != 'YOUR_HUGGINGFACE_API_KEY') {
      try {
        final hfResponse = await http.post(
          Uri.parse(_hfTextClassifyUrl),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'inputs': rawText}),
        );

        if (hfResponse.statusCode == 200) {
          final List<dynamic> data = jsonDecode(hfResponse.body);
          if (data.isNotEmpty && data[0] is List) {
            final predictions = data[0] as List;
            for (final pred in predictions) {
              final label = pred['label']?.toString() ?? '';
              final score = (pred['score'] as num?)?.toDouble() ?? 0.0;

              if ((label.contains('mwr') || label.contains('raj')) && score > 0.3) {
                return LanguageDetectionResult(
                  languageCode: 'mwr',
                  languageName: 'Marwari (मारवाड़ी)',
                  confidence: score,
                  isRegionalDialect: true,
                  normalizedText: _normalizeMarwariToHindi(rawText),
                );
              }
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Hugging Face Language Detection API Error: $e');
        }
      }
    }

    // 3. Rule-based Dialect Classification Fallback
    if (shekhawatiScore >= 2 || (shekhawatiScore > 0 && marwariScore > 0)) {
      return LanguageDetectionResult(
        languageCode: 'shk',
        languageName: 'Shekhawati (शेखावाटी)',
        confidence: 0.92,
        isRegionalDialect: true,
        normalizedText: _normalizeMarwariToHindi(rawText),
      );
    } else if (marwariScore >= 1) {
      return LanguageDetectionResult(
        languageCode: 'mwr',
        languageName: 'Marwari (मारवाड़ी)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: _normalizeMarwariToHindi(rawText),
      );
    }

    // Check English vs Hindi Script
    final isEnglishScript = RegExp(r'^[a-zA-Z0-9\s\?\,\.\!\%\-\_]+$').hasMatch(lowerText);
    if (isEnglishScript) {
      return LanguageDetectionResult(
        languageCode: 'en',
        languageName: 'English',
        confidence: 0.98,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    return LanguageDetectionResult(
      languageCode: 'hi',
      languageName: 'Hindi (हिंदी)',
      confidence: 0.90,
      isRegionalDialect: false,
      normalizedText: rawText,
    );
  }

  /// Sends farmer query to Hugging Face LLM Model trained for Marwari/Shekhawati multi-turn conversation
  static Future<String?> queryHuggingFaceModel({
    required String prompt,
    required String contextData,
    List<Map<String, String>>? history,
    String? apiKeyOverride,
    String? modelOverride,
  }) async {
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_HUGGINGFACE_API_KEY') {
      if (kDebugMode) {
        print('Hugging Face API Key is not set in AppConfig.huggingFaceApiKey');
      }
      return null;
    }

    final model = modelOverride ?? AppConfig.huggingFaceModel;

    final systemInstruction = '''
You are the official AI Agricultural Market & Logistics Specialist for Apna Godam (अपना गोदाम).
You specialize in continuous conversational voice chat with farmers in Marwari (मारवाड़ी) and Shekhawati (शेखावाटी) dialects.

CORE INSTRUCTIONS FOR MULTI-TURN VOICE CHAT:
1. Support multi-turn conversational context (e.g. if farmer asks "जौ का भाव क्या है?" and then asks "मुझे वो बेचना है कैसे बेचूं?", understand that "वो" refers to "जौ / Barley").
2. Respond DIRECTLY in friendly, respectful Marwari / Shekhawati dialect (e.g., "अजमेर मंडी में जों रो भाव ₹2150/क्विंटल छै। थै गोदाम में माल आसानी सूं बेच सको छौ।").
3. Use live market data context provided below:
$contextData

Provide concise, friendly, and accurate answers suitable for voice playback.
''';

    final List<Map<String, String>> messages = [
      {'role': 'system', 'content': systemInstruction},
    ];

    if (history != null && history.isNotEmpty) {
      for (final turn in history) {
        if (turn.containsKey('user')) {
          messages.add({'role': 'user', 'content': turn['user']!});
        }
        if (turn.containsKey('assistant')) {
          messages.add({'role': 'assistant', 'content': turn['assistant']!});
        }
      }
    }

    messages.add({'role': 'user', 'content': prompt});

    try {
      final response = await http.post(
        Uri.parse(_hfBaseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': model,
          'messages': messages,
          'temperature': 0.3,
          'max_tokens': 512,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final reply = data['choices'][0]['message']['content'] as String?;
          return reply?.trim();
        }
      } else {
        if (kDebugMode) {
          print('Hugging Face API HTTP ${response.statusCode}: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hugging Face Query Exception: $e');
      }
    }
    return null;
  }

  /// Transcribes speech audio bytes using Hugging Face Automatic Speech Recognition (ASR)
  static Future<String?> transcribeAudioHuggingFace({
    required List<int> audioBytes,
    String? apiKeyOverride,
  }) async {
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_HUGGINGFACE_API_KEY') {
      return null;
    }

    try {
      final response = await http.post(
        Uri.parse(_hfAsrUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'audio/wav',
        },
        body: audioBytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('text')) {
          return data['text'] as String?;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hugging Face ASR Exception: $e');
      }
    }
    return null;
  }

  /// Normalizes Marwari / Shekhawati dialect sentences into Standard Hindi
  static String _normalizeMarwariToHindi(String marwariText) {
    String normalized = marwariText;

    final replacements = {
      'गैहूं': 'गेहूं',
      'गेहू': 'गेहूं',
      'रो भाव': 'का भाव',
      'रा भाव': 'के भाव',
      'री कीमत': 'की कीमत',
      'कांई है': 'क्या है',
      'ाईं है': 'क्या है',
      'ाईं': 'क्या',
      'कांई': 'क्या',
      'किया': 'कैसे',
      'कतरा': 'कितने',
      'म्हाने': 'मुझे',
      'थै': 'आप',
      'थारो': 'आपका',
      'कराणो': 'कराना',
      'बेचणी': 'बेचना',
      'खरीदणी': 'खरीदना',
      'कोण्या': 'नहीं',
      'कोणी': 'नहीं',
      'लागैगा': 'लगेगा',
      'लागसी': 'लगेगा',
      'छै': 'है',
      'अठै': 'यहाँ',
      'बठै': 'वहाँ',
      'कठै': 'कहाँ',
    };

    replacements.forEach((key, value) {
      normalized = normalized.replaceAll(key, value);
    });

    return normalized;
  }
}
