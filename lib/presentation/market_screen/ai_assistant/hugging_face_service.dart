import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';

/// Language and Dialect Detection Result Model supporting 8 languages/dialects:
/// Marwari, Hindi, English, Bhojpuri, Maithili, Magahi, Angika, Bajika.
class LanguageDetectionResult {
  final String languageCode; // 'mwr', 'hi', 'en', 'bho', 'mai', 'mag', 'anp', 'bjk'
  final String languageName; // Display name with native script
  final double confidence;
  final bool isRegionalDialect;
  final String normalizedText;

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

/// Dedicated Hugging Face AI Service for 8-Language Dialect Detection & AI Inference
class HuggingFaceService {
  static const String _hfBaseUrl = 'https://router.huggingface.co/hf-inference/v1/chat/completions';
  static const String _hfAsrUrl = 'https://api-inference.huggingface.co/models/ai4bharat/indicwav2vec-v1-mwr';

  /// Detects input language/dialect across 8 targets:
  /// 1. Marwari (मारवाड़ी)
  /// 2. Hindi (हिंदी)
  /// 3. English
  /// 4. Bhojpuri (भोजपुरी)
  /// 5. Maithili (मैथिली)
  /// 6. Magahi (मगही)
  /// 7. Angika (अंगिका)
  /// 8. Bajika (बजिका)
  static Future<LanguageDetectionResult> detectLanguageAndDialect({
    required String text,
    String? apiKeyOverride,
  }) async {
    final rawText = text.trim();
    final lowerText = rawText.toLowerCase();

    if (rawText.isEmpty) {
      return LanguageDetectionResult(
        languageCode: 'mwr',
        languageName: 'Marwari (मारवाड़ी)',
        confidence: 1.0,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    }

    // ── 1. Bhojpuri (भोजपुरी) Markers ──
    final bhojpuriKeywords = [
      'का बा', 'केतना', 'कइसे', 'हमरा', 'रउआ', 'रउरा', 'बेचैक', 'कीने', 'कहाँ बा',
      'बाटे', 'बा', 'हमार', 'तोहार', 'बाड़ू', 'काहल', 'आईल', 'गईल'
    ];
    final bhojpuriRoman = [
      'ka ba', 'ketna', 'kaise', 'raua', 'raura', 'humra', 'bechek', 'kine', 'ba'
    ];

    // ── 2. Maithili (मैथिली) Markers ──
    final maithiliKeywords = [
      'अहाँ', 'अहाँक', 'की', 'कतबा', 'कोना', 'बेचब', 'कैनब', 'अछि', 'सकइत छी',
      'हमीरा', 'तोरा', 'छैत', 'भेल', 'कहलहुँ'
    ];
    final maithiliRoman = [
      'ahan', 'ahank', 'ki', 'katba', 'kona', 'bechab', 'kainab', 'achi', 'hira'
    ];

    // ── 3. Magahi (मगही) Markers ──
    final magahiKeywords = [
      'का हई', 'कितना हई', 'कइसे', 'हमरा के', 'तोरा', 'बेचे के हई', 'कीने के हई',
      'हई', 'बाढे', 'हलै', 'गेलई', 'अइलै'
    ];
    final magahiRoman = [
      'ka hai', 'kitna hai', 'humra ke', 'tora', 'beche ke hai', 'kine ke hai'
    ];

    // ── 4. Angika (अंगिका) Markers ──
    final angikaKeywords = [
      'की छै', 'कतना छै', 'केन्हें', 'हमरा', 'तोरा', 'बेचै लेल', 'किनै लेल',
      'छै', 'छौ', 'हिनका', 'ऐलै', 'गेलै'
    ];
    final angikaRoman = [
      'ki chhai', 'katna chhai', 'kenhe', 'bechai lel', 'kinai lel'
    ];

    // ── 5. Bajika (बजिका) Markers ──
    final bajikaKeywords = [
      'का बा', 'केतना बा', 'कइसे', 'हमरा के', 'अहाँ के', 'बेचे के बा', 'कीने के बा',
      'बानी', 'अथि'
    ];

    // ── 6. Marwari (मारवाड़ी) Markers ──
    final marwariKeywords = [
      'रो', 'रा', 'री', 'कांई', 'ाईं', 'म्हाने', 'म्हाका', 'थै', 'थारो', 'थांरो',
      'किया', 'कतरा', 'कठै', 'अठै', 'बठै', 'कोण्या', 'कोणी', 'छै', 'होवै', 'लागैगा',
      'लागसी', 'कराणो', 'बेचणी', 'खरीदणी', 'बोली', 'चिठ्ठो', 'बाजरी', 'गैहूं',
      'सरसो', 'मोठ', 'मंगफली', 'गवार', 'रोजा', 'रोजी'
    ];
    final marwariRoman = [
      'chhe', 'che', 'chha', 'chho', 'bechain', 'bechni', 'bechna', 'mhane',
      'tharo', 'the', 'kai', 'kain', 'katra', 'ktr', 'koni', 'kunya', 'atha', 'batha'
    ];

    int bhoScore = 0, maiScore = 0, magScore = 0, anpScore = 0, bjkScore = 0, mwrScore = 0;

    for (final kw in bhojpuriKeywords) {
      if (rawText.contains(kw)) bhoScore += 2;
    }
    for (final kw in bhojpuriRoman) {
      if (lowerText.contains(kw)) bhoScore += 2;
    }

    for (final kw in maithiliKeywords) {
      if (rawText.contains(kw)) maiScore += 2;
    }
    for (final kw in maithiliRoman) {
      if (lowerText.contains(kw)) maiScore += 2;
    }

    for (final kw in magahiKeywords) {
      if (rawText.contains(kw)) magScore += 2;
    }
    for (final kw in magahiRoman) {
      if (lowerText.contains(kw)) magScore += 2;
    }

    for (final kw in angikaKeywords) {
      if (rawText.contains(kw)) anpScore += 2;
    }
    for (final kw in angikaRoman) {
      if (lowerText.contains(kw)) anpScore += 2;
    }

    for (final kw in bajikaKeywords) {
      if (rawText.contains(kw)) bjkScore += 2;
    }

    for (final kw in marwariKeywords) {
      if (rawText.contains(kw)) mwrScore += 2;
    }
    for (final kw in marwariRoman) {
      if (lowerText.contains(kw)) mwrScore += 2;
    }

    // Evaluation Hierarchy
    if (bhoScore >= 2 && bhoScore >= maiScore && bhoScore >= mwrScore) {
      return LanguageDetectionResult(
        languageCode: 'bho',
        languageName: 'Bhojpuri (भोजपुरी)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    } else if (maiScore >= 2 && maiScore >= magScore) {
      return LanguageDetectionResult(
        languageCode: 'mai',
        languageName: 'Maithili (मैथिली)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    } else if (magScore >= 2 && magScore >= anpScore) {
      return LanguageDetectionResult(
        languageCode: 'mag',
        languageName: 'Magahi (मगही)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    } else if (anpScore >= 2) {
      return LanguageDetectionResult(
        languageCode: 'anp',
        languageName: 'Angika (अंगिका)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    } else if (bjkScore >= 2) {
      return LanguageDetectionResult(
        languageCode: 'bjk',
        languageName: 'Bajika (बजिका)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    } else if (mwrScore >= 1) {
      return LanguageDetectionResult(
        languageCode: 'mwr',
        languageName: 'Marwari (मारवाड़ी)',
        confidence: 0.95,
        isRegionalDialect: true,
        normalizedText: rawText,
      );
    }

    // Check pure English Query
    final isPureEnglishWordQuery = (lowerText.contains('what') ||
            lowerText.contains('how') ||
            lowerText.contains('price') ||
            lowerText.contains('rate') ||
            lowerText.contains('buy') ||
            lowerText.contains('sell') ||
            lowerText.contains('wheat') ||
            lowerText.contains('barley') ||
            lowerText.contains('inward') ||
            lowerText.contains('outward') ||
            lowerText.contains('wallet') ||
            lowerText.contains('loan')) &&
        !lowerText.contains('bhav') &&
        !lowerText.contains('bechain') &&
        !lowerText.contains('chhe') &&
        !lowerText.contains('ka ba') &&
        !lowerText.contains('hai');

    if (isPureEnglishWordQuery) {
      return LanguageDetectionResult(
        languageCode: 'en',
        languageName: 'English',
        confidence: 0.98,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    // Check standard Hindi Devanagari
    if (rawText.contains('क्या') || rawText.contains('कैसे') || rawText.contains('कितना') || rawText.contains('चाहिए')) {
      return LanguageDetectionResult(
        languageCode: 'hi',
        languageName: 'Hindi (हिंदी)',
        confidence: 0.92,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    // Default to Marwari / Regional for farmer queries
    return LanguageDetectionResult(
      languageCode: 'mwr',
      languageName: 'Marwari (मारवाड़ी)',
      confidence: 0.90,
      isRegionalDialect: true,
      normalizedText: rawText,
    );
  }

  /// Sends farmer query to Hugging Face LLM Model trained for 8 regional languages & Groundnut rules
  static Future<String?> queryHuggingFaceModel({
    required String prompt,
    required String contextData,
    List<Map<String, String>>? history,
    String? apiKeyOverride,
    String? modelOverride,
  }) async {
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_HUGGINGFACE_API_KEY') {
      return null;
    }

    final modelsToTry = [
      modelOverride ?? AppConfig.huggingFaceModel,
      'Qwen/Qwen2.5-7B-Instruct',
      'mistralai/Mistral-7B-Instruct-v0.3',
      'HuggingFaceH4/zephyr-7b-beta',
    ];

    final systemInstruction = '''
You are the official AI Agricultural Market & Customer Service Specialist for Apna Godam (अपना गोदाम).
You specialize in continuous conversational voice chat with farmers across 8 regional languages and dialects:
1. Marwari (मारवाड़ी)
2. Hindi (हिंदी)
3. English
4. Bhojpuri (भोजपुरी)
5. Maithili (मैथिली)
6. Magahi (मगही)
7. Angika (अंगिका)
8. Bajika (बजिका)

CRITICAL INSTRUCTIONS:
1. DETECT THE USER'S EXACT LANGUAGE/DIALECT (Marwari, Hindi, English, Bhojpuri, Maithili, Magahi, Angika, Bajika) AND RESPOND DIRECTLY IN THAT SAME LANGUAGE/DIALECT IN DEVANAGARI SCRIPT.
   - Example Marwari: "अजमेर मंडी में मूंगफली रो भाव ₹65/किग्रा छै सा। थै अपना गोदाम पर आसानी सूं बेच सको छौ।"
   - Example Bhojpuri: "अजमेर मंडी में मूंगफली के भाव ₹65/किलो बा। रउआ अपना गोदाम पर आसानी से बेच सकिला।"
   - Example Maithili: "अजमेर मंडी में मूंगफलीक भाव ₹65/किग्रा अछि। अहाँ अपना गोदाम पर आसानी सँ बेच सकइत छी।"
   - Example Hindi: "अजमेर मंडी में मूंगफली का भाव ₹65/किग्रा है। आप अपना गोदाम पर आसानी से बेच सकते हैं।"

2. GROUNDNUT (मूंगफली) DOMAIN & CUSTOMER SERVICE RULES:
   - Synonyms: मूंगफली, मूंफली, ग्राउंडनट, सिकाई मूंगफली, सिंगदाना, गोटा।
   - 3 Quality Types:
     a) सिकाई गुणवत्ता (Sikai Quality): Whole roasted/baked. Golden shell, grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi, Mohangarh, Bajju, Nachna). Only Khala (खला) type is used. Price ~₹60 to ₹70-75/kg. (Do NOT quote Sikai rates for Jaipur/Chomu/Sikar without quality test!).
     b) दाना गुणवत्ता (Dana Quality): Inner kernel/gota is good, outer shell thin. Sold shelled (singdana/gota). Only Khala (खला) type used.
     c) तेल गुणवत्ता (Oil Quality): Lighter seed/shell, thin kernels for oil extraction. Both Khala (खला) and Chugga (चुग्गा) types used.
   - Harvesting Types: Khala (खला - pulled with plant) vs Chugga (चुग्गा - detached in soil). Note: Chugga is treated as Oil Quality!
   - Truckload Rules: Full truckload = 20-25 Tons (23-27 Tons max). If farmer has ~25 Tons, dispatch trading member immediately! If low quantity (2-3 Tons or 4-6 bags), put on waitlist until full truckload is aggregated nearby.
   - Ownership Policy: Deals ONLY with land/stock owner (मालिक). If caller is Bataidar (बटाईदार) or laborer (मजदूर), politely request owner's phone number.
   - Location Verification: Always confirm actual storage location (do not assume caller current location).
   - Quality Parameters: 2-dana & 3-dana pods are positive (+ price), 1-dana pods are negative (- price due to extra peeling labor).

3. Live Market Data Context:
$contextData

Provide concise, polite, and dialect-accurate answers suitable for voice playback.
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

    for (final currentModel in modelsToTry) {
      try {
        final response = await http.post(
          Uri.parse(_hfBaseUrl),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': currentModel,
            'messages': messages,
            'temperature': 0.3,
            'max_tokens': 512,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['choices'] != null && data['choices'].isNotEmpty) {
            final reply = data['choices'][0]['message']['content'] as String?;
            if (reply != null && reply.trim().isNotEmpty) {
              return reply.trim();
            }
          }
        }
      } catch (_) {}
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
    } catch (_) {}
    return null;
  }
}
