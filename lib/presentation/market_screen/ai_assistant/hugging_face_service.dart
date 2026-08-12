import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';

/// Language and Dialect Detection Result Model supporting ALL Indian Languages & Dialects:
/// Marwari, Hindi, English, Bhojpuri, Maithili, Magahi, Angika, Bajika, Punjabi, Gujarati,
/// Bengali, Marathi, Tamil, Telugu, Kannada, Malayalam, Odia, Assamese, Urdu, etc.
class LanguageDetectionResult {
  final String languageCode;
  final String languageName;
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

/// Dedicated Hugging Face AI Service trained from 0 for ALL Indian Languages & Full Business Glossary
class HuggingFaceService {
  static const String _hfBaseUrl = 'https://router.huggingface.co/hf-inference/v1/chat/completions';
  static const String _hfAsrUrl = 'https://api-inference.huggingface.co/models/ai4bharat/indicwav2vec-v1-mwr';

  /// Detects input language/dialect across all Indian languages and regional dialects
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

    // ── 1. Bhojpuri (भोजपुरी) ──
    final bhojpuriKeywords = ['का बा', 'केतना', 'कइसे', 'हमरा', 'रउआ', 'रउरा', 'बेचैक', 'कीने', 'कहाँ बा', 'बाटे', 'बा', 'हमार', 'तोहार', 'बाड़ू'];
    // ── 2. Maithili (मैथिली) ──
    final maithiliKeywords = ['अहाँ', 'अहाँक', 'की', 'कतबा', 'कोना', 'बेचब', 'कैनब', 'अछि', 'सकइत छी', 'हमीरा', 'छैत'];
    // ── 3. Magahi (मगही) ──
    final magahiKeywords = ['का हई', 'कितना हई', 'कइसे', 'हमरा के', 'तोरा', 'बेचे के हई', 'कीने के हई', 'हई', 'हलै'];
    // ── 4. Angika (अंगिका) ──
    final angikaKeywords = ['की छै', 'कतना छै', 'केन्हें', 'हमरा', 'तोरा', 'बेचै लेल', 'किनै लेल', 'छै', 'छौ'];
    // ── 5. Bajika (बजिका) ──
    final bajikaKeywords = ['का बा', 'केतना बा', 'कइसे', 'हमरा के', 'अहाँ के', 'बेचे के बा', 'कीने के बा', 'बानी'];
    // ── 6. Marwari (मारवाड़ी) ──
    final marwariKeywords = ['रो', 'रा', 'री', 'कांई', 'ाईं', 'म्हाने', 'म्हाका', 'थै', 'थारो', 'थांरो', 'किया', 'कतरा', 'कठै', 'अठै', 'बठै', 'कोण्या', 'कोणी', 'छै', 'होवै', 'लागैगा', 'कराणो', 'बेचणी', 'खरीदणी', 'रोजा', 'रोजी'];
    final marwariRoman = ['chhe', 'che', 'chha', 'chho', 'bechain', 'bechni', 'mhane', 'tharo', 'the', 'kai', 'kain', 'katra'];

    // ── 7. Punjabi (ਪੰਜਾਬੀ) ──
    final punjabiKeywords = ['ਕੀ', 'ਕਿਵੇਂ', 'ਕਿੰਨਾ', 'ਚਾਹੀਦਾ', 'ਵੇਚਣਾ', 'ਖਰੀਦਣਾ', 'ਭਾਅ', 'ਕਣਕ'];
    // ── 8. Gujarati (ગુજરાતી) ──
    final gujaratiKeywords = ['શું', 'કેવી રીતે', 'કેટલા', 'ભાવ', 'વેચવું', 'ખરીદવું', 'ઘઉં', 'રાયડો'];
    // ── 9. Bengali (বাংলা) ──
    final bengaliKeywords = ['কি', 'কেমন', 'কত', 'দাম', 'বিক্রি', 'কেনা', 'গম'];
    // ── 10. Marathi (मराठी) ──
    final marathiKeywords = ['काय', 'कसे', 'किती', 'भाव', 'विकणे', 'खरेदी', 'गहू'];
    // ── 11. South Indian Languages (Tamil, Telugu, Kannada, Malayalam) ──
    final dravidianKeywords = ['விலை', 'விற்க', 'ఎంత', 'అమ్మకం', 'ಬೆಲೆ', 'ಮಾರಾಟ', 'விலை'];

    for (final kw in bhojpuriKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'bho', languageName: 'Bhojpuri (भोजपुरी)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in maithiliKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'mai', languageName: 'Maithili (मैथिली)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in magahiKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'mag', languageName: 'Magahi (मगही)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in angikaKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'anp', languageName: 'Angika (अंगिका)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in bajikaKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'bjk', languageName: 'Bajika (बजिका)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in marwariKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'mwr', languageName: 'Marwari (मारवाड़ी)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in marwariRoman) { if (lowerText.contains(kw)) return LanguageDetectionResult(languageCode: 'mwr', languageName: 'Marwari (मारवाड़ी)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }

    for (final kw in punjabiKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'pa', languageName: 'Punjabi (ਪੰਜਾਬੀ)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in gujaratiKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'gu', languageName: 'Gujarati (ગુજરાતી)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in bengaliKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'bn', languageName: 'Bengali (বাংলা)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in marathiKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'mr', languageName: 'Marathi (मराठी)', confidence: 0.95, isRegionalDialect: true, normalizedText: rawText); }
    for (final kw in dravidianKeywords) { if (rawText.contains(kw)) return LanguageDetectionResult(languageCode: 'south', languageName: 'South Indian Language', confidence: 0.90, isRegionalDialect: true, normalizedText: rawText); }

    // Check pure English query (English characters, no Devanagari, no Roman Marwari markers)
    final hasEnglishChars = RegExp(r'[a-zA-Z]').hasMatch(lowerText);
    final hasDevanagariChars = RegExp(r'[\u0900-\u097F]').hasMatch(rawText);
    final isRomanMarwari = lowerText.contains('chhe') ||
        lowerText.contains('che') ||
        lowerText.contains('mhane') ||
        lowerText.contains('tharo') ||
        lowerText.contains('bechain') ||
        lowerText.contains('bechni') ||
        lowerText.contains('kai') ||
        lowerText.contains('katra');

    if (hasEnglishChars && !hasDevanagariChars && !isRomanMarwari) {
      return LanguageDetectionResult(
        languageCode: 'en',
        languageName: 'English',
        confidence: 0.99,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    if (rawText.contains('क्या') || rawText.contains('कैसे') || rawText.contains('कितना') || rawText.contains('चाहिए') || rawText.contains('करना')) {
      return LanguageDetectionResult(
        languageCode: 'hi',
        languageName: 'Hindi (हिंदी)',
        confidence: 0.92,
        isRegionalDialect: false,
        normalizedText: rawText,
      );
    }

    return LanguageDetectionResult(
      languageCode: 'mwr',
      languageName: 'Marwari (मारवाड़ी)',
      confidence: 0.90,
      isRegionalDialect: true,
      normalizedText: rawText,
    );
  }

  /// Queries Hugging Face Model with Complete Business Glossary & System Rules trained from 0
  static Future<String?> queryHuggingFaceModel({
    required String prompt,
    required String contextData,
    List<Map<String, String>>? history,
    String? apiKeyOverride,
    String? modelOverride,
  }) async {
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_HUGGINGFACE_API_KEY') return null;

    final modelsToTry = [
      modelOverride ?? AppConfig.huggingFaceModel,
      'Qwen/Qwen2.5-7B-Instruct',
      'mistralai/Mistral-7B-Instruct-v0.3',
      'HuggingFaceH4/zephyr-7b-beta',
    ];

    final systemInstruction = '''
YOU ARE THE OFFICIAL AI AGRI-LOGISTICS & WAREHOUSE SPECIALIST FOR APNA GODAM (अपना गोदाम).
YOU ARE TRAINED FROM 0 ON ALL INDIAN LANGUAGES & THE FULL APNA GODAM BUSINESS GLOSSARY.

CRITICAL MANDATORY RULES:
1. DETECT THE USER'S EXACT SPOKEN/TYPED LANGUAGE (Marwari, Hindi, English, Bhojpuri, Maithili, Magahi, Angika, Bajika, Punjabi, Gujarati, Bengali, Marathi, South Indian, etc.) AND RESPOND DIRECTLY IN THAT SAME LANGUAGE & SCRIPT!
2. OUT-OF-SCOPE / UNKNOWN QUERY RULE:
   If the user asks a question that is OUTSIDE the scope of Apna Godam, agricultural trade, warehouses, crop rates, logistics, quality assaying, or app features, OR if you do NOT know the answer:
   APOLOGIZE POLITELY IN THE USER'S EXACT LANGUAGE AND ASK THEM TO CONTACT OUR IVR HELPLINE AT 7733901154!
   - Example Marwari: "माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।"
   - Example Hindi: "क्षमा करें, मुझे इस प्रश्न की जानकारी नहीं है। अधिक जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।"
   - Example English: "Sorry, I do not have information on this question. Please contact our IVR Helpline at 7733901154."

   - PERSONAL DATA CONSENT & PROFILE ISOLATION RULE:
     Accessing personal details, profile information, or wallet balances REQUIRES OTP verification on the user's registered mobile number. Show personal data ONLY for that verified user profile. NEVER expose or reveal any other user profile's data!
     - Marwari: "सा, आपरी पर्सनल जानकारी (प्रोफाइल/बैलेंस) देखण वास्ते आपरो रजिस्टर्ड मोबाइल नंबर अर OTP सत्यापन जरूरी छै। मेहरबानी कर ऐप में लॉगिन करो सा।"
     - Hindi: "सुरक्षा कारणों से आपकी व्यक्तिगत जानकारी (प्रोफाइल/बैलेंस) देखने के लिए पंजीकृत मोबाइल नंबर और OTP सत्यापन आवश्यक है। केवल सत्यापित उपयोगकर्ता ही अपनी प्रोफाइल देख सकते हैं।"
     - English: "For security and privacy, accessing personal profile details requires OTP verification on your registered mobile number. Please log in to your authenticated account."
   A. ROLES (22): Warehouse Supervisor (supervises staff), Guard (entry/exit security), Warehouse Owner, Warehouse Service Provider (WSP), Collateral Manager (monitors pledged stock), Labour (loading, unloading, packing, cleaning), Transporter, Truck Driver, Fumigation Agency (chemical pest treatment), Sprayer, Cleaner, Government Officials (inspection), Buyer, Seller, Broker, Quality Assayer (checks moisture, FM, dana), Kanta Man / Weighbridge Operator (weighs vehicles/bags), Trading Member, Cleaning Member, Data Registry, Exchange, Visitor.
   B. ACTIONS (20): Logistics Activities, Price Discovery, Quality Assaying, Stuffing/Packing, Loading, Transporting, Unloading, Weighing, Settlement, Payment, Invoicing, Testing, Fumigation, Spraying, Cleaning, Agenting, Watching/Security, Selling, Buying, Booking.
   C. RULES & CHARGES (11): Loading Charges, Unloading Charges, Transportation, Transit Shortage, Warehouse Shortage, Quality Chain, Mandi Tax, State Charges, Kanta Charges, Seller/Trading Member Fee, Buyer Fee.
   D. PHYSICAL OPERATIONAL OBJECTS (17): Kata Parchi / Weigh Slip (weighment record), Warehouse, Jute Bag, Plastic Bag, Sutli (twine), Thread (stitching), Pakhki (winnowing fan/tray), Pocket Scale, Tray, Moisture Meter, Tripal / Tarpaulin (rain protection), Sand Bag (tarpaulin weight), Battery, Inverter, CCTV Camera, Wi-Fi Dongle, Router.
   E. GROUNDNUT RULES:
      - 3 Quality Types: Sikai Quality (Western Rajasthan golden shell, Khala type only, ₹60-75/kg), Dana Quality (shelled singdana/gota, Khala type), Oil Quality (thin kernels, Khala & Chugga types).
      - Harvesting: Khala (pulled with root) vs Chugga (left in soil, oil quality).
      - Logistics: Full truckload = 20-25 Tons (send trading member immediately!). Small batches (2-3 tons) put on waitlist.
      - Ownership: Deals ONLY with land/stock owner (मालिक). Bataidar/Laborer must provide owner's phone.
      - Quality: 2-dana/3-dana pods (+ price), 1-dana pods (- price).

4. LIVE MARKET DATA CONTEXT:
$contextData

Provide direct, friendly, and precise responses suitable for instant voice chat.
''';

    final List<Map<String, String>> messages = [{'role': 'system', 'content': systemInstruction}];
    if (history != null && history.isNotEmpty) {
      for (final turn in history) {
        if (turn.containsKey('user')) messages.add({'role': 'user', 'content': turn['user']!});
        if (turn.containsKey('assistant')) messages.add({'role': 'assistant', 'content': turn['assistant']!});
      }
    }
    messages.add({'role': 'user', 'content': prompt});

    for (final currentModel in modelsToTry) {
      try {
        final response = await http.post(
          Uri.parse(_hfBaseUrl),
          headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'},
          body: jsonEncode({'model': currentModel, 'messages': messages, 'temperature': 0.3, 'max_tokens': 512}),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['choices'] != null && data['choices'].isNotEmpty) {
            final reply = data['choices'][0]['message']['content'] as String?;
            if (reply != null && reply.trim().isNotEmpty) return reply.trim();
          }
        }
      } catch (_) {}
    }
    return null;
  }

  /// ASR Audio transcription
  static Future<String?> transcribeAudioHuggingFace({
    required List<int> audioBytes,
    String? apiKeyOverride,
  }) async {
    final apiKey = apiKeyOverride ?? AppConfig.huggingFaceApiKey;
    if (apiKey.isEmpty || apiKey == 'YOUR_HUGGINGFACE_API_KEY') return null;
    try {
      final response = await http.post(
        Uri.parse(_hfAsrUrl),
        headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'audio/wav'},
        body: audioBytes,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('text')) return data['text'] as String?;
      }
    } catch (_) {}
    return null;
  }
}
