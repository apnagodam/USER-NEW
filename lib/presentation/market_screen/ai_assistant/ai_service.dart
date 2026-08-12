import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';
import 'hugging_face_service.dart';

enum AiModel { operations, sales, accounts }

class AiService {
  static const String _apiUrl = 'https://api.anthropic.com/v1/messages';

  static const List<String> _modelsToTry = [
    'claude-3-haiku-20240307',
    'claude-3-sonnet-20240229',
    'claude-3-5-haiku-20241022',
    'claude-3-5-sonnet-20241022',
    'claude-3-5-sonnet-latest',
    'claude-3-5-haiku-latest',
  ];

  /// Sends a farmer's question with live market data as context.
  static Future<String> askClaude({
    required String question,
    required String marketData,
    List<Map<String, String>>? history,
    bool isHindi = true,
  }) async {
    // 1. Try Hugging Face Inference API Model for regional dialect across all Indian languages
    try {
      final hfResult = await HuggingFaceService.queryHuggingFaceModel(
        prompt: question,
        contextData: marketData,
        history: history,
      );
      if (hfResult != null && hfResult.trim().isNotEmpty) {
        return hfResult;
      }
    } catch (e) {
      if (kDebugMode) print('HuggingFace Inference Error: $e');
    }

    final systemPrompt = _buildSystemPrompt(
      question: question,
      marketData: marketData,
    );

    final List<Map<String, String>> messages = [];
    if (history != null && history.isNotEmpty) {
      for (final turn in history) {
        if (turn.containsKey('user')) messages.add({'role': 'user', 'content': turn['user']!});
        if (turn.containsKey('assistant')) messages.add({'role': 'assistant', 'content': turn['assistant']!});
      }
    }
    messages.add({'role': 'user', 'content': question});

    for (final modelName in _modelsToTry) {
      try {
        final response = await http.post(
          Uri.parse(_apiUrl),
          headers: {
            'x-api-key': AppConfig.claudeApiKey,
            'anthropic-version': '2023-06-01',
            'content-type': 'application/json',
          },
          body: jsonEncode({
            'model': modelName,
            'max_tokens': 512,
            'system': systemPrompt,
            'messages': messages,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['content'][0]['text'] as String;
        }
      } catch (_) {}
    }

    return fallbackMarketResponse(question, marketData, history: history);
  }

  /// Smart local answer generator covering ALL Roles, Actions, Charges, Objects, and IVR Fallback.
  static String fallbackMarketResponse(
    String question,
    String marketData, {
    List<Map<String, String>>? history,
  }) {
    final q = question.toLowerCase().trim();

    // Detect English Query: English letters, no Devanagari, no Roman Marwari markers
    final hasEnglishChars = RegExp(r'[a-zA-Z]').hasMatch(q);
    final hasDevanagariChars = RegExp(r'[\u0900-\u097F]').hasMatch(question);
    final isRomanMarwari = q.contains('chhe') ||
        q.contains('che') ||
        q.contains('mhane') ||
        q.contains('tharo') ||
        q.contains('bechain') ||
        q.contains('bechni') ||
        q.contains('kai') ||
        q.contains('katra');

    final isEnglishQuery = hasEnglishChars && !hasDevanagariChars && !isRomanMarwari;

    // Detect Dialects
    final isBhojpuri = q.contains('का बा') || q.contains('केतना') || q.contains('कइसे') || q.contains('हमरा') || q.contains('रउआ') || q.contains('बाते');
    final isMaithili = q.contains('अहाँ') || q.contains('की') || q.contains('कतबा') || q.contains('कोना') || q.contains('अछि');

    // ── 0. PERSONAL DATA CONSENT & PROFILE ISOLATION RULE ──
    if (q.contains('पर्सनल') ||
        q.contains('प्रोफाइल') ||
        q.contains('प्रोफ़ाइल') ||
        q.contains('माहरो अकाउंट') ||
        q.contains('मेरा अकाउंट') ||
        q.contains('मेरा बैलेंस') ||
        q.contains('मेरा डिटेल') ||
        q.contains('profile') ||
        q.contains('personal') ||
        q.contains('my account') ||
        q.contains('my balance')) {
      if (isEnglishQuery) {
        return 'For security and privacy, accessing personal profile details requires OTP verification on your registered mobile number. Please log in to your authenticated account. (Data is shown ONLY for your own profile)';
      }
      return 'सा, आपरी पर्सनल जानकारी (प्रोफाइल/बैलेंस) देखण वास्ते आपरो रजिस्टर्ड मोबाइल नंबर अर OTP सत्यापन जरूरी छै। मेहरबानी कर ऐप में लॉगिन करो सा।';
    }

    // ── 1. WEIGH SLIP / KATA PARCHI (कांटा पर्ची) ──
    if (q.contains('कांटा पर्ची') || q.contains('कट पर्ची') || q.contains('kata parchi') || q.contains('weigh slip') || q.contains('तोल पर्ची')) {
      if (isEnglishQuery) {
        return 'Kata Parchi (Weigh Slip) records the official weighment transaction including gross weight, tare weight, net weight, vehicle number, date/time, and material details.';
      }
      return 'कांटा पर्ची (Weigh Slip) में वजन रो पूरो ब्योरो, गाड़ी नंबर, तारीख, सकल अर शुद्ध वजन दर्ज होवै छै सा।';
    }

    // ── 2. MOISTURE METER & PAKHKI & TRIPAL (नमी मापक / तिरपाल / पाखी) ──
    if (q.contains('नमी') || q.contains('moisture') || q.contains('तिरपाल') || q.contains('tripal') || q.contains('पाखी') || q.contains('pakhki')) {
      if (isEnglishQuery) {
        return 'Moisture Meter measures moisture % in grain before inward. Tripal/Tarpaulin protects stored crop bags from rain and dust. Pakhki is used for winnowing and cleaning grain.';
      }
      return 'नमी मापक (Moisture Meter) सूं अनाज री नमी जांची जावै छै सा। तिरपाल सूं बोरियां री सुरक्षा होवै छै सा, अर पाखी सूं अनाज री सफाई करी जावै छै सा।';
    }

    // ── 3. ROLES (कांटा मैन, सुपरवाइजर, लेबर, क्वालिटी अस्सेयर) ──
    if (q.contains('कांटा मैन') || q.contains('kanta man') || q.contains('weighbridge operator') || q.contains('तोल अधिकारी')) {
      if (isEnglishQuery) {
        return 'Kanta Man / Weighbridge Operator performs and records the exact weighing operations of trucks and commodity bags.';
      }
      return 'कांटा मैन (Weighbridge Operator) धर्म कांटा पर गाड़ियां अर अनाज रो सही वजन कर कांटा पर्ची देवै छै सा।';
    }

    if (q.contains('क्वालिटी') || q.contains('quality assayer') || q.contains('गुणवत्ता जांच')) {
      if (isEnglishQuery) {
        return 'Quality Assayer samples, tests, and records grain quality parameters such as moisture %, foreign matter (FM), damaged grain, and oil content.';
      }
      return 'क्वालिटी अस्सेयर (Quality Assayer) अनाज रो सैंपल लेइने नमी (Moisture %), कचरा (FM) अर गुणवत्ता री जांच कर रिपोर्ट दर्ज करे छै सा।';
    }

    if (q.contains('सुपरवाइजर') || q.contains('supervisor') || q.contains('लेबर') || q.contains('labour')) {
      if (isEnglishQuery) {
        return 'Warehouse Supervisor oversees staff & daily operations. Labour handles loading, unloading, stitching, stacking, and cleaning.';
      }
      return 'गोदाम सुपरवाइजर पूरी व्यवस्था री देखरेख करे छै सा। लेबर (मजदूर) माल री लोडिंग, अनलोडिंग, बोरी सिलाई अर सफाई रो काम करे छै सा।';
    }

    // ── 4. CHARGES (लोडिंग, अनलोडिंग, मंडी टैक्स, कांटा चार्ज) ──
    if (q.contains('चार्ज') || q.contains('शुल्क') || q.contains('charge') || q.contains('tax') || q.contains('टैक्स')) {
      if (isEnglishQuery) {
        return 'Applicable warehouse rules specify loading/unloading charges, transportation freight, Mandi tax, state charges, and weighbridge (Kanta) fees.';
      }
      return 'अपना गोदाम में लोडिंग/अनलोडिंग चार्ज, परिवहन भाड़ो, मंडी टैक्स अर कांटा पर्ची चार्ज नियमानुसार पारदर्शी रूप सूं लागू होवै छै सा।';
    }

    // ── 5. GROUNDNUT (मूंगफली) DOMAIN KNOWLEDGE RULES ──
    if (q.contains('सिकाई') || q.contains('रोस्टेड') || q.contains('sikai') || q.contains('roasted')) {
      if (isEnglishQuery) {
        return 'Sikai Quality Groundnut is whole roasted groundnut grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi). It uses Khala harvesting type and rates range from ₹60 to ₹70-75/kg.';
      }
      return 'सिकाई मूंगफली मुख्य रूप सूं पश्चिमी राजस्थान (जैसलमेर, बीकानेर) री छै सा। छिलका सुनहलो अर भाव ₹60 सूं ₹75/किग्रा तक छै सा।';
    }

    if (q.contains('चुग्गा') || q.contains('खला') || q.contains('chugga') || q.contains('khala')) {
      return 'पौधे सागे जड़ सूं निकलण वाली मूंगफली ने "खला" कहे छै सा। जमीन मांय रह जाण वाली मूंगफली ने "चुग्गा" कहे छै सा। चुग्गा ने मुख्य रूप सूं तेल गुणवत्ता (Oil Quality) रो मान्यो जावै छै सा।';
    }

    if (q.contains('टन') || q.contains('ट्रक') || q.contains('truck') || q.contains('ton') || q.contains('मात्रा')) {
      return 'मूंगफली री सामान्य ट्रक क्षमता 20 सूं 25 टन होवै छै सा। यदि आपरे पाखे 25 टन माल छै, तो आपरे वास्ते तुरंत ट्रेडिंग सदस्य भेज्यो ज्यासी सा। कम मात्रा वाला किसानों ने वेटलिस्ट मांय राख्यो जावै सा।';
    }

    if (q.contains('बटाईदार') || q.contains('मजदूर') || q.contains('मालिक') || q.contains('bataidar') || q.contains('owner')) {
      return 'मूंगफली रो सौदा केवल जमीन या माल रा वैध मालिक सागे ही कर्यो जावै छै सा। यदि आप बटाईदार या मजदूर हो, तो मालिक रो नंबर देवो सा।';
    }

    // ── 6. PROCESSES (इनवर्ड, आउटवर्ड, गेटपास, व्यापार) ──
    if (q.contains('इनवर्ड') || q.contains('inward') || q.contains('माल जमा') || q.contains('जमा')) {
      return 'गोदाम मांय माल जमा (Inward) करावण वास्ते:\n1. ऐप में "माल जमा" पर क्लिक करो सा।\n2. आपरो गोदाम, जिंस अर स्टैक नंबर चुणो सा।\n3. वजन अर गाड़ी नंबर भर समिट करो सा।';
    }

    if (q.contains('आउटवर्ड') || q.contains('outward') || q.contains('निकासी') || q.contains('निकाल')) {
      return 'गोदाम सूं माल काढण (Outward) वास्ते:\n1. ऐप में "माल निकासी" पर जावो सा।\n2. आपरो स्टैक चुणो अर सबमिट करो सा।';
    }

    if (q.contains('गेट पास') || q.contains('गेटपास') || q.contains('gatepass') || q.contains('gate pass') || q.contains('banaun') || q.contains('banaye')) {
      return 'डिजिटल गेट पास (Gate Pass) बणावण वास्ते इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करो सा, अप्रूवल मिलता ही QR कोड गेट पास ऐप में बण ज्यासी सा।';
    }

    // ── 7. CROP RATES INQUIRY ──
    String searchedCropName = '';
    String cropDisplayName = '';
    String cropDisplayNameEn = '';
    List<String> keywords = [];

    if (q.contains('गेहूं') || q.contains('gehu') || q.contains('wheat')) {
      searchedCropName = 'गेहूं'; cropDisplayName = 'गेहूं'; cropDisplayNameEn = 'Wheat'; keywords = ['गेहूं', 'wheat'];
    } else if (q.contains('जौ') || q.contains('jau') || q.contains('barley')) {
      searchedCropName = 'जौ'; cropDisplayName = 'जौ'; cropDisplayNameEn = 'Barley'; keywords = ['जौ', 'barley'];
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram')) {
      searchedCropName = 'चना'; cropDisplayName = 'चना'; cropDisplayNameEn = 'Gram'; keywords = ['चना', 'gram'];
    } else if (q.contains('सरसों') || q.contains('mustard') || q.contains('रोजा') || q.contains('रोजी')) {
      searchedCropName = 'सरसों'; cropDisplayName = 'सरसों'; cropDisplayNameEn = 'Mustard'; keywords = ['सरसों', 'mustard', 'सरसो'];
    } else if (q.contains('मूंगफली') || q.contains('mungfali') || q.contains('groundnut') || q.contains('सिंगदाना') || q.contains('गोटा')) {
      searchedCropName = 'मूंगफली'; cropDisplayName = 'मूंगफली'; cropDisplayNameEn = 'Groundnut'; keywords = ['मूंगफली', 'groundnut', 'सिकाई', 'सिंगदाना'];
    } else if (q.contains('मक्का') || q.contains('maize')) {
      searchedCropName = 'मक्का'; cropDisplayName = 'मक्का'; cropDisplayNameEn = 'Maize'; keywords = ['मक्का', 'maize'];
    }

    if (searchedCropName.isNotEmpty && marketData.isNotEmpty) {
      final lines = marketData.split('\n');
      num? foundPrice;

      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final lineLower = line.toLowerCase();
        for (final kw in keywords) {
          if (lineLower.contains(kw)) {
            final priceMatch = RegExp(r'₹\s*([\d\.]+)').firstMatch(line);
            if (priceMatch != null) {
              final pStr = priceMatch.group(1)!;
              if (pStr != 'N/A') {
                final pDouble = double.tryParse(pStr);
                if (pDouble != null && pDouble > 0) {
                  foundPrice = (pDouble % 1 == 0) ? pDouble.toInt() : pDouble;
                  break;
                }
              }
            }
          }
        }
        if (foundPrice != null && foundPrice > 0) break;
      }

      final priceDisplay = foundPrice ?? (searchedCropName == 'मूंगफली' ? 65 : 2469);

      if (isEnglishQuery) {
        return 'Today\'s rate for $cropDisplayNameEn is ₹$priceDisplay. Do you want to buy or sell?';
      }
      return 'आज $cropDisplayName रो भाव ₹$priceDisplay/क्विंटल छै सा। थै खरीदना चाहो छौ या बेचना चाहो छौ?';
    }

    // ── 8. UNKNOWN / OUT-OF-SCOPE QUERY FALLBACK TO IVR HELPLINE (7733901154) ──
    if (isEnglishQuery) {
      return 'Sorry, I do not have information on this out-of-scope question. Please contact our IVR Helpline at 7733901154 for assistance.';
    }
    if (isBhojpuri) {
      return 'क्षमा करीं, हमरा ई सवाल के जानकारी नईखे। अधिक जानकारी खातिर हमार IVR हेल्पलाइन 7733901154 पर कॉल करीं।';
    }
    if (isMaithili) {
      return 'क्षमा करू, हमरा ऐ प्रश्नक जानकारी नहि अछि। अधिक जानकारी लेल हमर IVR हेल्पलाइन 7733901154 पर कॉल करू।';
    }

    // Default to PURE MARWARI for all unknown regional questions
    return 'माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।';
  }

  static String _buildSystemPrompt({
    required String question,
    required String marketData,
  }) {
    return '''CRITICAL MANDATORY MARWARI RESPONSE RULE:
1. ALWAYS RESPOND IN PURE RESPECTFUL MARWARI (मारवाड़ी) DIALECT IN DEVANAGARI SCRIPT FOR ALL REGIONAL/HINDI QUERIES!
   - NEVER RESPOND IN STANDARD HINDI!
   - Marwari Example: "आज मूंगफली रो भाव ₹65/किग्रा छै सा। थै अपना गोदाम पर आसानी सूं बेच सको छौ।"

2. OUT-OF-SCOPE / UNKNOWN QUESTION RULE:
   If the question is outside Apna Godam business, crops, rates, logistics, or quality:
   APOLOGIZE POLITELY IN MARWARI AND REDIRECT TO IVR HELPLINE 7733901154!
   - Marwari: "माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।"

LIVE MARKET DATA:
$marketData''';
  }
}
