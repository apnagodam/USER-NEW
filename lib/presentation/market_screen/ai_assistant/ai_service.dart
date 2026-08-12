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
    final isBhojpuri = q.contains('का बा') || q.contains('केतना') || q.contains('कइसे') || q.contains('हमरा') || q.contains('हमार') || q.contains('रउआ') || q.contains('बाते') || q.contains('बा') || q.contains('करीं') || q.contains('बनी') || q.contains('बताईं');
    final isMaithili = q.contains('अहाँ') || q.contains('की') || q.contains('कतबा') || q.contains('कोना') || q.contains('अछि');
    final isHindi = q.contains('क्या') || q.contains('कैसे') || q.contains('कितना') || q.contains('बनाएं') || q.contains('बताएं') || q.contains('बताओ');

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
      if (isBhojpuri) {
        return 'सुरक्षा अउर गोपनीयता खातिर पर्सनल जानकारी देखे खातिर रजिस्टर्ड मोबाइल नंबर पर OTP सत्यापन जरूरी बा। मेहरबानी कर के ऐप में लॉगिन करीं।';
      }
      if (isHindi) {
        return 'सुरक्षा और गोपनीयता कारणों से व्यक्तिगत जानकारी (प्रोफाइल/बैलेंस) देखने के लिए पंजीकृत मोबाइल नंबर और OTP सत्यापन आवश्यक है।';
      }
      return 'सा, आपरी पर्सनल जानकारी (प्रोफाइल/बैलेंस) देखण वास्ते आपरो रजिस्टर्ड मोबाइल नंबर अर OTP सत्यापन जरूरी छै। मेहरबानी कर ऐप में लॉगिन करो सा।';
    }

    // ── 1. WEIGH SLIP / KATA PARCHI (कांटा पर्ची) ──
    if (q.contains('कांटा पर्ची') || q.contains('कट पर्ची') || q.contains('kata parchi') || q.contains('kanta parchi') || q.contains('weigh slip') || q.contains('तोल पर्ची')) {
      if (isEnglishQuery) {
        return 'Kata Parchi (Weigh Slip) records the official weighment transaction including gross weight, tare weight, net weight, vehicle number, date/time, and material details.';
      }
      if (isBhojpuri) {
        return 'कांटा पर्ची (Weigh Slip) में तोल के पूरा विवरण दर्ज होला, जवना में गाड़ी के वजन (Gross/Tare Weight), कुल शुद्ध वजन, वाहन नंबर अउर तारीख शामिल होला।';
      }
      if (isHindi) {
        return 'कांटा पर्ची (Weigh Slip) में तोल का पूरा विवरण दर्ज होता है, जिसमें गाड़ी का वजन (Gross/Tare Weight), कुल शुद्ध वजन, वाहन नंबर और तारीख शामिल होती है।';
      }
      return 'कांटा पर्ची (Weigh Slip) में वजन रो पूरो ब्योरो, गाड़ी नंबर, तारीख, सकल अर शुद्ध वजन दर्ज होवै छै सा।';
    }

    // ── 2. MOISTURE METER & PAKHKI & TRIPAL (नमी मापक / तिरपाल / पाखी) ──
    if (q.contains('नमी') || q.contains('moisture') || q.contains('तिरपाल') || q.contains('tripal') || q.contains('पाखी') || q.contains('pakhki')) {
      if (isEnglishQuery) {
        return 'Moisture Meter measures moisture % in grain before inward. Tripal/Tarpaulin protects stored crop bags from rain and dust. Pakhki is used for winnowing and cleaning grain.';
      }
      if (isBhojpuri) {
        return 'नमी मापक (Moisture Meter) से अनाज के नमी जांचल जाला। तिरपाल फसल के बोरियन के सुरक्षा करेला अउर पाखी से अनाज के सफाई कईल जाला।';
      }
      if (isHindi) {
        return 'नमी मापक (Moisture Meter) से अनाज की नमी जांची जाती है। तिरपाल (Tarpaulin) फसल की बोरियों की सुरक्षा करता है और पाखी से अनाज की सफाई की जाती है।';
      }
      return 'नमी मापक (Moisture Meter) सूं अनाज री नमी जांची जावै छै सा। तिरपाल सूं बोरियां री सुरक्षा होवै छै सा, अर पाखी सूं अनाज री सफाई करी जावै छै सा।';
    }

    // ── 3. ROLES (कांटा मैन, सुपरवाइजर, लेबर, क्वालिटी अस्सेयर) ──
    if (q.contains('कांटा मैन') || q.contains('kanta man') || q.contains('weighbridge operator') || q.contains('तोल अधिकारी')) {
      if (isEnglishQuery) {
        return 'Kanta Man / Weighbridge Operator performs and records the exact weighing operations of trucks and commodity bags.';
      }
      if (isBhojpuri) {
        return 'कांटा मैन (Weighbridge Operator) धर्म कांटा पर गाड़ियन अउर अनाज के सही वजन करे के अउर कांटा पर्ची जारी करे के काम करेला।';
      }
      if (isHindi) {
        return 'कांटा मैन (Weighbridge Operator) धर्म कांटा पर गाड़ियों और अनाज का सही वजन करने और कांटा पर्ची जारी करने का काम करता है।';
      }
      return 'कांटा मैन (Weighbridge Operator) धर्म कांटा पर गाड़ियां अर अनाज रो सही वजन कर कांटा पर्ची देवै छै सा।';
    }

    if (q.contains('क्वालिटी') || q.contains('quality assayer') || q.contains('गुणवत्ता जांच')) {
      if (isEnglishQuery) {
        return 'Quality Assayer samples, tests, and records grain quality parameters such as moisture %, foreign matter (FM), damaged grain, and oil content.';
      }
      if (isBhojpuri) {
        return 'क्वालिटी अस्सेयर (Quality Assayer) अनाज के सैंपल लेके नमी (Moisture %), कचरा (FM) अउर गुणवत्ता के जांच क के रिपोर्ट दर्ज करेला।';
      }
      if (isHindi) {
        return 'क्वालिटी अस्सेयर (Quality Assayer) अनाज का सैंपल लेकर नमी (Moisture %), कचरा (FM) और गुणवत्ता मापदंडों की जांच कर रिपोर्ट दर्ज करता है।';
      }
      return 'क्वालिटी अस्सेयर (Quality Assayer) अनाज रो सैंपल लेइने नमी (Moisture %), कचरा (FM) अर गुणवत्ता री जांच कर रिपोर्ट दर्ज करे छै सा।';
    }

    if (q.contains('सुपरवाइजर') || q.contains('supervisor') || q.contains('लेबर') || q.contains('labour')) {
      if (isEnglishQuery) {
        return 'Warehouse Supervisor oversees staff & daily operations. Labour handles loading, unloading, stitching, stacking, and cleaning.';
      }
      if (isBhojpuri) {
        return 'गोदाम सुपरवाइजर पूरा व्यवस्था के देखरेख करेला। लेबर (मजदूर) लोडिंग, अनलोडिंग, सिलाई अउर सफाई के काम करेला।';
      }
      if (isHindi) {
        return 'गोदाम सुपरवाइजर पूरी व्यवस्था और कर्मचारियों की देखरेख करता है। लेबर (मजदूर) लोडिंग, अनलोडिंग, सिलाई और सफाई का कार्य करती है।';
      }
      return 'गोदाम सुपरवाइजर पूरी व्यवस्था री देखरेख करे छै सा। लेबर (मजदूर) माल री लोडिंग, अनलोडिंग, बोरी सिलाई अर सफाई रो काम करे छै सा।';
    }

    // ── 4. CHARGES (लोडिंग, अनलोडिंग, मंडी टैक्स, कांटा चार्ज) ──
    if (q.contains('चार्ज') || q.contains('शुल्क') || q.contains('charge') || q.contains('tax') || q.contains('टैक्स')) {
      if (isEnglishQuery) {
        return 'Applicable warehouse rules specify loading/unloading charges, transportation freight, Mandi tax, state charges, and weighbridge (Kanta) fees.';
      }
      if (isBhojpuri) {
        return 'अपना गोदाम में लोडिंग/अनलोडिंग चार्ज, परिवहन भाड़ा, मंडी टैक्स अउर कांटा पर्ची चार्ज नियमानुसार पारदर्शी रूप से लागू होला।';
      }
      if (isHindi) {
        return 'अपना गोदाम में लोडिंग/अनलोडिंग चार्ज, परिवहन भाड़ा, मंडी टैक्स और कांटा पर्ची चार्ज नियमानुसार पारदर्शी रूप से लागू होते हैं।';
      }
      return 'अपना गोदाम में लोडिंग/अनलोडिंग चार्ज, परिवहन भाड़ो, मंडी टैक्स अर कांटा पर्ची चार्ज नियमानुसार पारदर्शी रूप सूं लागू होवै छै सा।';
    }

    // ── 5. GROUNDNUT (मूंगफली) DOMAIN KNOWLEDGE RULES ──
    if (q.contains('सिकाई') || q.contains('रोस्टेड') || q.contains('sikai') || q.contains('roasted')) {
      if (isEnglishQuery) {
        return 'Sikai Quality Groundnut is whole roasted groundnut grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi). It uses Khala harvesting type.';
      }
      if (isBhojpuri) {
        return 'सिकाई मूंगफली पच्छिमी राजस्थान (जैसलमेर, बीकानेर) में होला। एकर बाहरी छिलका सुनहला होला।';
      }
      if (isHindi) {
        return 'सिकाई मूंगफली मुख्य रूप से पश्चिमी राजस्थान (जैसलमेर, बीकानेर) में उगाई जाती है। इसका बाहरी छिलका सुनहरे रंग का होता है।';
      }
      return 'सिकाई मूंगफली मुख्य रूप सूं पश्चिमी राजस्थान (जैसलमेर, बीकानेर) री छै सा। छिलका सुनहलो होवै छै सा।';
    }

    if (q.contains('चुग्गा') || q.contains('खला') || q.contains('chugga') || q.contains('khala')) {
      if (isEnglishQuery) {
        return 'Khala groundnut is harvested with plant roots. Chugga groundnut is detached pods left in soil, which is categorized under Oil Quality.';
      }
      if (isBhojpuri) {
        return 'पौधा के साथ जड़ से निकले वाला मूंगफली के "खला" कहल जाला। जमीन में छूट गईल मूंगफली के "चुग्गा" कहल जाला। चुग्गा के मुख्य रूप से तेल गुणवत्ता (Oil Quality) के मानल जाला।';
      }
      if (isHindi) {
        return 'पौधे के साथ जड़ से निकलने वाली मूंगफली को "खला" कहते हैं। जमीन में रह जाने वाली मूंगफली को "चुग्गा" कहते हैं। चुग्गा को मुख्य रूप से तेल गुणवत्ता (Oil Quality) का माना जाता है।';
      }
      return 'पौधे सागे जड़ सूं निकलण वाली मूंगफली ने "खला" कहे छै सा। जमीन मांय रह जाण वाली मूंगफली ने "चुग्गा" कहे छै सा। चुग्गा ने मुख्य रूप सूं तेल गुणवत्ता (Oil Quality) रो मान्यो जावै छै सा।';
    }

    if (q.contains('टन') || q.contains('ट्रक') || q.contains('truck') || q.contains('ton') || q.contains('मात्रा')) {
      if (isEnglishQuery) {
        return 'Full truckload capacity is 20-25 Tons (up to 27 Tons max). If you have ~25 Tons, a trading member will be dispatched immediately!';
      }
      if (isBhojpuri) {
        return 'मूंगफली के सामान्य ट्रक क्षमता 20 से 25 टन होला। यदि रउआ लगे 25 टन माल बा, तो रउआ खातिर तुरंत ट्रेडिंग सदस्य भेजल जाई!';
      }
      if (isHindi) {
        return 'मूंगफली की सामान्य ट्रक क्षमता 20 से 25 टन होती है। यदि आपके पास लगभग 25 टन माल है, तो आपके लिए तुरंत ट्रेडिंग सदस्य भेजा जाएगा।';
      }
      return 'मूंगफली री सामान्य ट्रक क्षमता 20 सूं 25 टन होवै छै सा। यदि आपरे पाखे 25 टन माल छै, तो आपरे वास्ते तुरंत ट्रेडिंग सदस्य भेज्यो ज्यासी सा।';
    }

    if (q.contains('बटाईदार') || q.contains('मजदूर') || q.contains('मालिक') || q.contains('bataidar') || q.contains('owner')) {
      if (isEnglishQuery) {
        return 'Apna Godam trades exclusively with valid land/stock owners. If you are a Bataidar or laborer, please provide the owner\'s mobile number.';
      }
      if (isBhojpuri) {
        return 'मूंगफली के सौदा सिर्फ जमीन भा माल के वैध मालिक के साथे ही कइल जाला। यदि रउआ बटाईदार भा मजदूर बानी, तो मालिक के नंबर दीं।';
      }
      if (isHindi) {
        return 'मूंगफली का सौदा केवल जमीन या माल के वैध मालिक के साथ ही किया जाता है। यदि आप बटाईदार या मजदूर हैं, तो कृपया मालिक का मोबाइल नंबर उपलब्ध कराएं।';
      }
      return 'मूंगफली रो सौदा केवल जमीन या माल रा वैध मालिक सागे ही कर्यो जावै छै सा। यदि आप बटाईदार या मजदूर हो, तो मालिक रो नंबर देवो सा।';
    }

    // ── 6. PROCESSES (इनवर्ड, आउटवर्ड, गेटपास, व्यापार) ──
    if (q.contains('इनवर्ड') || q.contains('inward') || q.contains('माल जमा') || q.contains('जमा')) {
      if (isEnglishQuery) {
        return 'To deposit goods (Inward):\n1. Tap "Inwards" in the app.\n2. Select warehouse, commodity & stack number.\n3. Enter weight (quintals), vehicle number & driver phone to submit.';
      }
      if (isBhojpuri) {
        return 'गोदाम में माल जमा (Inward) करे खातिर:\n1. ऐप में "माल जमा" पर क्लिक करीं।\n2. अपना गोदाम, अनाज अउर स्टैक नंबर चुनीं।\n3. वजन अउर गाड़ी नंबर भर के सबमिट करीं।';
      }
      if (isHindi) {
        return 'गोदाम में माल जमा (Inward) करने के लिए:\n1. ऐप में "माल जमा" पर क्लिक करें।\n2. अपना गोदाम, अनाज और स्टैक नंबर चुनें।\n3. वजन और वाहन नंबर दर्ज करके सबमिट करें।';
      }
      return 'गोदाम मांय माल जमा (Inward) करावण वास्ते:\n1. ऐप में "माल जमा" पर क्लिक करो सा।\n2. आपरो गोदाम, जिंस अर स्टैक नंबर चुणो सा।\n3. वजन अर गाड़ी नंबर भर समिट करो सा।';
    }

    if (q.contains('आउटवर्ड') || q.contains('outward') || q.contains('निकासी') || q.contains('निकाल')) {
      if (isEnglishQuery) {
        return 'To withdraw goods (Outward):\n1. Tap "Outward" in the warehouse section.\n2. Select your warehouse, commodity and stack.\n3. Enter withdrawal weight and vehicle details to submit.';
      }
      if (isBhojpuri) {
        return 'गोदाम से माल निकाले (Outward) खातिर:\n1. ऐप में "माल निकासी" पर क्लिक करीं।\n2. अपना गोदाम अउर स्टैक चुन के वजन दर्ज करीं अउर सबमिट करीं।';
      }
      if (isHindi) {
        return 'गोदाम से माल निकालने (Outward) के लिए:\n1. ऐप में "माल निकासी" पर क्लिक करें।\n2. अपना गोदाम और स्टैक चुनकर वजन दर्ज करें और सबमिट करें।';
      }
      return 'गोदाम सूं माल काढण (Outward) वास्ते:\n1. ऐप में "माल निकासी" पर जावो सा।\n2. आपरो स्टैक चुणो अर सबमिट करो सा।';
    }

    if (q.contains('गेट पास') || q.contains('गेटपास') || q.contains('gatepass') || q.contains('gate pass') || q.contains('banaun') || q.contains('banaye')) {
      if (isEnglishQuery) {
        return 'Digital Gate Pass is generated automatically once your Inward or Outward request is approved, displaying your QR code, stack number and vehicle details.';
      }
      if (isBhojpuri) {
        return 'डिजिटल गेट पास (Gate Pass) बनावे खातिर इनवर्ड भा आउटवर्ड रिक्वेस्ट सबमिट करीं, अप्रूवल मिलत ही ऐप में QR कोड गेट पास जारी हो जाई।';
      }
      if (isHindi) {
        return 'डिजिटल गेट पास (Gate Pass) बनाने के लिए इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करें, अप्रूवल मिलते ही ऐप में QR कोड गेट पास जारी हो जाएगा।';
      }
      return 'डिजिटल गेट पास (Gate Pass) बणावण वास्ते इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करो सा, अप्रूवल मिलता ही QR कोड गेट पास ऐप में बण ज्यासी सा।';
    }

    // ── 7. LIVE CROP RATES INQUIRY (STRICT BACKEND API DATA ONLY - NO HARDCODED NUMBERS) ──
    String searchedCropName = '';
    String cropDisplayName = '';
    String cropDisplayNameEn = '';
    List<String> keywords = [];

    if (q.contains('गेहूं') || q.contains('gehu') || q.contains('wheat')) {
      searchedCropName = 'गेहूं'; cropDisplayName = 'गेहूं'; cropDisplayNameEn = 'Wheat'; keywords = ['गेहूं', 'wheat', 'gehu'];
    } else if (q.contains('जौ') || q.contains('jau') || q.contains('barley')) {
      searchedCropName = 'जौ'; cropDisplayName = 'जौ'; cropDisplayNameEn = 'Barley'; keywords = ['जौ', 'barley', 'barley 2026', 'jau', 'jo'];
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram')) {
      searchedCropName = 'चना'; cropDisplayName = 'चना'; cropDisplayNameEn = 'Gram'; keywords = ['चना', 'gram', 'chana'];
    } else if (q.contains('सरसों') || q.contains('mustard') || q.contains('रोजा') || q.contains('रोजी')) {
      searchedCropName = 'सरसों'; cropDisplayName = 'सरसों'; cropDisplayNameEn = 'Mustard'; keywords = ['सरसों', 'mustard', 'sarso', 'सरसो'];
    } else if (q.contains('मूंगफली') || q.contains('mungfali') || q.contains('groundnut') || q.contains('ground nut') || q.contains('सिंगदाना') || q.contains('गोटा')) {
      searchedCropName = 'मूंगफली'; cropDisplayName = 'मूंगफली'; cropDisplayNameEn = 'Groundnut'; keywords = ['मूंगफली', 'ground nut', 'groundnut', 'mungfali', 'सिकाई', 'सिंगदाना', 'गोटा', 'oil quality'];
    } else if (q.contains('मक्का') || q.contains('maize')) {
      searchedCropName = 'मक्का'; cropDisplayName = 'मक्का'; cropDisplayNameEn = 'Maize'; keywords = ['मक्का', 'maize', 'makka'];
    }

    if (searchedCropName.isNotEmpty) {
      num? foundPrice;
      if (marketData.isNotEmpty) {
        final lines = marketData.split('\n');
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
      }

      // If NO live rate found in backend API -> Direct to IVR Helpline in Spoken Language!
      if (foundPrice == null) {
        if (isEnglishQuery) {
          return 'Currently, live market rates for $cropDisplayNameEn are not available in the backend API. Please contact our IVR Helpline at 7733901154 for live rates.';
        }
        if (isBhojpuri) {
          return 'अभी $cropDisplayName के लाइव मंडी भाव उपलब्ध नईखे। ताजा भाव खातिर हमार IVR हेल्पलाइन 7733901154 पर कॉल करीं।';
        }
        if (isHindi) {
          return 'फिलहाल $cropDisplayName का लाइव मंडी भाव उपलब्ध नहीं है। ताज़ा भाव की जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।';
        }
        return 'सा, इण समय $cropDisplayName रो लाइव भाव उपलब्ध कोइनी सा। ताजा भाव वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।';
      }

      final priceDisplay = foundPrice;

      if (isEnglishQuery) {
        return 'Today\'s live rate for $cropDisplayNameEn is ₹$priceDisplay/quintal on Apna Godam. Do you want to buy or sell?';
      }
      if (isBhojpuri) {
        return 'आज $cropDisplayName के लाइव भाव ₹$priceDisplay/क्विंटल बा। रउआ खरीदे के बा कि बेचे के बा?';
      }
      if (isHindi) {
        return 'आज $cropDisplayName का लाइव भाव ₹$priceDisplay/क्विंटल है। आप खरीदना चाहते हैं या बेचना चाहते हैं?';
      }
      return 'आज $cropDisplayName रो लाइव भाव ₹$priceDisplay/क्विंटल छै सा। थै खरीदना चाहो छौ या बेचना चाहो छौ?';
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
    if (isHindi) {
      return 'क्षमा करें, मुझे इस प्रश्न की जानकारी नहीं है। अधिक जानकारी के लिए कृपया हमारी IVR हेल्पलाइन 7733901154 पर कॉल करें।';
    }

    return 'माफ़ करना सा, म्हाने इण सवाल रो जवाब कोइनी। बत्ती जानकारी वास्ते आप IVR हेल्पलाइन 7733901154 पर कॉल करो सा।';
  }

  static String _buildSystemPrompt({
    required String question,
    required String marketData,
  }) {
    return '''CRITICAL LANGUAGE ROUTING RULE:
1. DETECT THE USER'S EXACT SPOKEN LANGUAGE AND RESPOND IN THAT SAME LANGUAGE:
   - ENGLISH QUERY ("how make gatepass", "what is kanta parchi"): RESPOND 100% IN PURE ENGLISH!
   - BHOJPURI QUERY ("मूंगफली के भाव केतन बा"): RESPOND 100% IN PURE BHOJPURI!
   - HINDI QUERY ("गेटपास कैसे बनाएं"): RESPOND 100% IN PURE SIMPLE HINDI!
   - MARWARI QUERY ("गेटपास किया बणावा सा"): RESPOND 100% IN PURE RESPECTFUL MARWARI!

2. LIVE BACKEND API PRICES ONLY:
   - NEVER SHOW HARDCODED FAKE NUMBERS (60, 70, 75, 2469)!
   - USE ONLY REAL LIVE RATES FROM BACKEND API (`$marketData`).
   - IF BACKEND API HAS NO PRICE FOR THAT CROP, RESPOND WITH A POLITE MESSAGE DIRECTING THEM TO IVR HELPLINE AT 7733901154 IN THEIR RESPECTIVE LANGUAGE!

LIVE MARKET DATA:
$marketData''';
  }
}
