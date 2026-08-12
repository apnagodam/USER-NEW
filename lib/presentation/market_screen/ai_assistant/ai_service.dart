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

    // Detect English
    final isEnglishQuery = (q.contains('what') || q.contains('how') || q.contains('price') || q.contains('rate') || q.contains('buy') || q.contains('sell') || q.contains('wheat') || q.contains('groundnut') || q.contains('inward') || q.contains('outward') || q.contains('wallet') || q.contains('loan') || q.contains('who') || q.contains('role') || q.contains('weigh') || q.contains('slip')) && RegExp(r'^[a-zA-Z0-9\s\?\,\.\!\%\-\_]+$').hasMatch(q);

    // Detect Dialects
    final isBhojpuri = q.contains('का बा') || q.contains('केतना') || q.contains('कइसे') || q.contains('हमरा') || q.contains('रउआ') || q.contains('बाते');
    final isMaithili = q.contains('अहाँ') || q.contains('की') || q.contains('कतबा') || q.contains('कोना') || q.contains('अछि');
    final isMarwari = q.contains('रो') || q.contains('कांई') || q.contains('ाईं') || q.contains('म्हाने') || q.contains('थै') || q.contains('कराणो') || q.contains('छै');

    // ── 1. WEIGH SLIP / KATA PARCHI (कांटा पर्ची) ──
    if (q.contains('कांटा पर्ची') || q.contains('कट पर्ची') || q.contains('kata parchi') || q.contains('weigh slip') || q.contains('तोल पर्ची')) {
      if (isEnglishQuery) {
        return 'Kata Parchi (Weigh Slip) records the official weighment transaction including gross weight, tare weight, net weight, vehicle number, date/time, and material details.';
      }
      if (isMarwari) {
        return 'कांटा पर्ची (Weigh Slip) में वजन रो पूरो ब्योरो, गाड़ी नंबर, तारीख, सकल अर शुद्ध वजन दर्ज होवै छै सा।';
      }
      return 'कांटा पर्ची (Weigh Slip) में तोल का पूरा विवरण दर्ज होता है, जिसमें गाड़ी का वजन (Gross/Tare Weight), कुल शुद्ध वजन, वाहन नंबर और तारीख शामिल होती है।';
    }

    // ── 2. MOISTURE METER & PAKHKI & TRIPAL (नमी मापक / तिरपाल / पाखी) ──
    if (q.contains('नमी') || q.contains('moisture') || q.contains('तिरपाल') || q.contains('tripal') || q.contains('पाखी') || q.contains('pakhki')) {
      if (isEnglishQuery) {
        return 'Moisture Meter measures moisture % in grain before inward. Tripal/Tarpaulin protects stored crop bags from rain and dust. Pakhki is used for winnowing and cleaning grain.';
      }
      return 'नमी मापक (Moisture Meter) से अनाज की नमी जांची जाती है। तिरपाल (Tarpaulin) फसल की बोरियों को बारिश और धूल से बचाता है, तथा पाखी का उपयोग अनाज सफाई के लिए किया जाता है।';
    }

    // ── 3. ROLES (कांटा मैन, सुपरवाइजर, लेबर, क्वालिटी अस्सेयर) ──
    if (q.contains('कांटा मैन') || q.contains('kanta man') || q.contains('weighbridge operator') || q.contains('तोल अधिकारी')) {
      if (isEnglishQuery) {
        return 'Kanta Man / Weighbridge Operator performs and records the exact weighing operations of trucks and commodity bags.';
      }
      return 'कांटा मैन (Weighbridge Operator) धर्म कांटा पर गाड़ियों और अनाज का सही वजन करने और कांटा पर्ची जारी करने का काम करता है।';
    }

    if (q.contains('क्वालिटी') || q.contains('quality assayer') || q.contains('गुणवत्ता जांच')) {
      if (isEnglishQuery) {
        return 'Quality Assayer samples, tests, and records grain quality parameters such as moisture %, foreign matter (FM), damaged grain, and oil content.';
      }
      return 'क्वालिटी अस्सेयर (Quality Assayer) अनाज का सैंपल लेकर नमी (Moisture %), कचरा (FM), दाना और गुणवत्ता मापदंडों की जांच कर रिपोर्ट दर्ज करता है।';
    }

    if (q.contains('सुपरवाइजर') || q.contains('supervisor') || q.contains('लेबर') || q.contains('labour')) {
      if (isEnglishQuery) {
        return 'Warehouse Supervisor oversees staff & daily operations. Labour handles loading, unloading, stitching, stacking, and cleaning.';
      }
      return 'गोदाम सुपरवाइजर पूरी व्यवस्था और कर्मचारियों की देखरेख करता है। लेबर (मजदूर) माल की लोडिंग, अनलोडिंग, बोरी सिलाई, स्टैकिंग और सफाई का कार्य करती है।';
    }

    // ── 4. CHARGES (लोडिंग, अनलोडिंग, मंडी टैक्स, कांटा चार्ज) ──
    if (q.contains('चार्ज') || q.contains('शुल्क') || q.contains('charge') || q.contains('tax') || q.contains('टैक्स')) {
      if (isEnglishQuery) {
        return 'Applicable warehouse rules specify loading/unloading charges, transportation freight, Mandi tax, state charges, and weighbridge (Kanta) fees.';
      }
      return 'अपना गोदाम में लोडिंग/अनलोडिंग चार्ज, परिवहन भाड़ा, मंडी टैक्स, राज्य शुल्क और कांटा पर्ची चार्ज नियमानुसार पारदर्शी रूप से लागू होते हैं।';
    }

    // ── 5. GROUNDNUT (मूंगफली) DOMAIN KNOWLEDGE RULES ──
    if (q.contains('सिकाई') || q.contains('रोस्टेड') || q.contains('sikai') || q.contains('roasted')) {
      if (isEnglishQuery) {
        return 'Sikai Quality Groundnut is whole roasted groundnut grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi). It uses Khala harvesting type and rates range from ₹60 to ₹70-75/kg.';
      }
      return isMarwari
          ? 'सिकाई मूंगफली मुख्य रूप सूं पश्चिमी राजस्थान (जैसलमेर, बीकानेर) री छै सा। छिलका सुनहलो अर भाव ₹60 सूं ₹75/किग्रा तक छै।'
          : 'सिकाई मूंगफली मुख्य रूप से पश्चिमी राजस्थान (जैसलमेर, बीकानेर, फलोदी) में उगाई जाती है। इसका बाहरी छिलका सुनहरे रंग का होता है और केवल खला प्रकार की मूंगफली सिकाई में काम आती है। भाव ₹60 से ₹70–75 प्रति किग्रा तक रहता है।';
    }

    if (q.contains('चुग्गा') || q.contains('खला') || q.contains('chugga') || q.contains('khala')) {
      return 'पौधे के साथ जड़ से निकलने वाली मूंगफली को "खला" कहते हैं। जमीन में रह जाने वाली मूंगफली को "चुग्गा" कहते हैं। चुग्गा को मुख्य रूप से तेल गुणवत्ता (Oil Quality) का माना जाता है।';
    }

    if (q.contains('टन') || q.contains('ट्रक') || q.contains('truck') || q.contains('ton') || q.contains('मात्रा')) {
      return 'मूंगफली की सामान्य ट्रक क्षमता 20 से 25 टन (23-27 टन) होती है। यदि आपके पास लगभग 25 टन माल है, तो आपके लिए तुरंत ट्रेडिंग सदस्य भेजा जाएगा। कम मात्रा (2-3 टन) वाले किसानों को ट्रक पूरा होने तक प्रतीक्षा सूची में रखा जाता है।';
    }

    if (q.contains('बटाईदार') || q.contains('मजदूर') || q.contains('मालिक') || q.contains('bataidar') || q.contains('owner')) {
      return 'मूंगफली का सौदा केवल जमीन या माल के वैध मालिक के साथ ही किया जाता है। यदि आप बटाईदार या मजदूर हैं, तो कृपया मालिक का मोबाइल नंबर उपलब्ध कराएं।';
    }

    // ── 6. PROCESSES (इनवर्ड, आउटवर्ड, गेटपास, व्यापार) ──
    if (q.contains('इनवर्ड') || q.contains('inward') || q.contains('माल जमा') || q.contains('जमा')) {
      return 'गोदाम में माल जमा (Inward) करने के लिए:\n1. ऐप में "माल जमा" (Inwards) पर क्लिक करें।\n2. अपना गोदाम टर्मिनल, अनाज और स्टैक नंबर चुनें।\n3. वजन (क्विंटल), वाहन नंबर और ड्राइवर मोबाइल नंबर दर्ज करके सबमिट करें।';
    }

    if (q.contains('आउटवर्ड') || q.contains('outward') || q.contains('निकासी') || q.contains('निकाल')) {
      return 'गोदाम से माल निकालने (Outward) के लिए:\n1. ऐप के गोदाम सेक्शन में "माल निकासी" पर क्लिक करें।\n2. अपना गोदाम और अनाज चुनकर संबंधित स्टैक चुनें।\n3. निकासी वजन और वाहन विवरण भरकर सबमिट करें।';
    }

    if (q.contains('गेट पास') || q.contains('गेटपास') || q.contains('gatepass') || q.contains('gate pass') || q.contains('banaun') || q.contains('banaye')) {
      return 'डिजिटल गेट पास (Gate Pass) बनाने के लिए इनवर्ड या आउटवर्ड रिक्वेस्ट अप्रूव होते ही ऐप में डिजिटल QR गेट पास जारी हो जाता है, जिससे तुरंत प्रवेश मिलता है।';
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
      return isMarwari
          ? 'आज $cropDisplayName रो भाव ₹$priceDisplay/क्विंटल छै सा। थै खरीदना चाहो छौ या बेचना चाहो छौ?'
          : 'आज $cropDisplayName का भाव ₹$priceDisplay/क्विंटल है। आप खरीदना चाहते हैं या बेचना चाहते हैं?';
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
    if (isMarwari) {
      return 'माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।';
    }

    return 'क्षमा करें, मुझे इस प्रश्न की जानकारी नहीं है। अधिक जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।';
  }

  static String _buildSystemPrompt({
    required String question,
    required String marketData,
  }) {
    return '''CRITICAL MULTI-DIALECT & OUT-OF-SCOPE IVR FALLBACK RULE:
1. MATCH THE USER'S EXACT LANGUAGE/DIALECT & SCRIPT IN YOUR RESPONSE!
2. OUT-OF-SCOPE / UNKNOWN QUESTION RULE:
   If the user asks an out-of-scope question outside Apna Godam business, crops, rates, logistics, or quality, OR if you do NOT know the answer:
   APOLOGIZE POLITELY IN THE USER'S EXACT LANGUAGE AND INSTRUCT THEM TO CALL OUR IVR HELPLINE AT 7733901154!
   - Marwari: "माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।"
   - Hindi: "क्षमा करें, मुझे इस प्रश्न की जानकारी नहीं है। अधिक जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।"
   - English: "Sorry, I do not have information on this question. Please contact our IVR Helpline at 7733901154."

3. FULL APNA GODAM BUSINESS KNOWLEDGE BASE:
   - 22 Roles: Warehouse Supervisor, Guard, Warehouse Owner, WSP, Collateral Manager, Labour, Transporter, Truck Driver, Fumigation Agency, Sprayer, Cleaner, Govt Officials, Buyer, Seller, Broker, Quality Assayer, Kanta Man (Weighbridge Operator), Trading Member, Data Registry, Exchange.
   - 20 Actions: Logistics, Price Discovery, Quality Assaying, Stuffing/Packing, Loading, Transporting, Unloading, Weighing, Settlement, Payment, Invoicing, Testing, Fumigation, Spraying, Cleaning, Watching/Security, Selling, Buying, Booking.
   - 11 Rules/Charges: Loading/Unloading charges, Freight, Transit Shortage, Warehouse Shortage, Quality Chain, Mandi Tax, State Charges, Kanta Charges, Trading Member Fee, Buyer Fee.
   - 17 Objects: Kata Parchi (Weigh Slip), Warehouse, Jute Bag, Plastic Bag, Sutli, Thread, Pakhki (Winnowing fan), Pocket Scale, Tray, Moisture Meter, Tripal / Tarpaulin, Sand Bag, Battery, Inverter, CCTV Camera, Wi-Fi Dongle, Router.
   - Groundnut Quality Rules: Sikai Quality (Western Rajasthan, Khala type, ₹60-75/kg), Dana Quality (singdana/gota), Oil Quality (thin kernels, Khala & Chugga). 20-25T full truckload rule. Deals ONLY with land/stock owners (मालिक).

LIVE MARKET DATA:
$marketData''';
  }
}
