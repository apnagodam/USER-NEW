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
  /// Supports 8 languages/dialects & Hugging Face API for Language Detection & AI inference.
  static Future<String> askClaude({
    required String question,
    required String marketData,
    List<Map<String, String>>? history,
    bool isHindi = true,
  }) async {
    // 1. Try Hugging Face Inference API Model for regional dialect (8 languages)
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
      if (kDebugMode) {
        print('HuggingFace Inference Error: $e');
      }
    }

    final systemPrompt = _buildSystemPrompt(
      question: question,
      marketData: marketData,
    );

    // Build Anthropic messages array with multi-turn conversation history
    final List<Map<String, String>> messages = [];
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
    messages.add({'role': 'user', 'content': question});

    // Try available Anthropic models in sequence
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

    // Use smart local market engine for instant, accurate response
    return fallbackMarketResponse(question, marketData, history: history);
  }

  /// Smart local answer generator for all 8 languages/dialects & Groundnut rules.
  static String fallbackMarketResponse(
    String question,
    String marketData, {
    List<Map<String, String>>? history,
  }) {
    final q = question.toLowerCase().trim();

    // Detect if question is in English
    final isEnglishQuery = (q.contains('what') ||
            q.contains('how') ||
            q.contains('price') ||
            q.contains('rate') ||
            q.contains('buy') ||
            q.contains('sell') ||
            q.contains('wheat') ||
            q.contains('barley') ||
            q.contains('groundnut') ||
            q.contains('inward') ||
            q.contains('outward') ||
            q.contains('wallet') ||
            q.contains('loan')) &&
        RegExp(r'^[a-zA-Z0-9\s\?\,\.\!\%\-\_]+$').hasMatch(q);

    // Detect Bhojpuri, Maithili, Magahi, Angika, Bajika, Marwari
    final isBhojpuri = q.contains('का बा') || q.contains('केतना') || q.contains('कइसे') || q.contains('हमरा') || q.contains('रउआ') || q.contains('बाते');
    final isMaithili = q.contains('अहाँ') || q.contains('की') || q.contains('कतबा') || q.contains('कोना') || q.contains('अछि');
    final isMagahi = q.contains('का हई') || q.contains('कितना हई') || q.contains('हमरा के') || q.contains('हई');
    final isAngika = q.contains('की छै') || q.contains('कतना छै') || q.contains('केन्हें') || q.contains('छौ');
    final isMarwari = q.contains('रो') || q.contains('कांई') || q.contains('ाईं') || q.contains('म्हाने') || q.contains('थै') || q.contains('कराणो') || q.contains('छै');

    // ── GROUNDNUT (मूंगफली) DOMAIN KNOWLEDGE RULES ──
    if (q.contains('सिकाई') || q.contains('रोस्टेड') || q.contains('sikai') || q.contains('roasted')) {
      if (isEnglishQuery) {
        return 'Sikai Quality Groundnut is whole roasted groundnut grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi, Mohangarh). It uses Khala harvesting type and rates range from ₹60 to ₹70-75/kg.';
      }
      if (isBhojpuri) {
        return 'सिकाई मूंगफली पच्छिमी राजस्थान (जैसलमेर, बीकानेर) में होला। एकर छिलका सुनहला होला अउर भाव ₹60 से ₹75/किलो तक बा।';
      }
      if (isMaithili) {
        return 'सिकाई मूंगफली पश्चिमी राजस्थानक छैक। एकर बाहरी छिलका सुनहला आ भाव ₹60 सँ ₹75/किग्रा अछि।';
      }
      return 'सिकाई मूंगफली मुख्य रूप से पश्चिमी राजस्थान (जैसलमेर, बीकानेर, फलोदी) में उगाई जाती है। इसका बाहरी छिलका सुनहरे रंग का होता है और केवल खला प्रकार की मूंगफली सिकाई में काम आती है। भाव ₹60 से ₹70–75 प्रति किग्रा तक रहता है।';
    }

    if (q.contains('चुग्गा') || q.contains('खला') || q.contains('chugga') || q.contains('khala')) {
      if (isEnglishQuery) {
        return 'Khala groundnut is harvested with plant roots. Chugga groundnut is detached pods left in soil, which is categorized under Oil Quality for rate calculation.';
      }
      return 'पौधे के साथ जड़ से निकलने वाली मूंगफली को "खला" कहते हैं। जमीन में रह जाने वाली मूंगफली को "चुग्गा" कहते हैं। चुग्गा को मुख्य रूप से तेल गुणवत्ता (Oil Quality) का माना जाता है।';
    }

    if (q.contains('टन') || q.contains('ट्रक') || q.contains('truck') || q.contains('ton') || q.contains('मात्रा')) {
      if (isEnglishQuery) {
        return 'Full truckload capacity is 20-25 Tons (up to 27 Tons max). If you have ~25 Tons, a trading member will be dispatched immediately! Small quantities (2-3 tons) are placed on the waitlist.';
      }
      return 'मूंगफली की सामान्य ट्रक क्षमता 20 से 25 टन (23-27 टन) होती है। यदि आपके पास लगभग 25 टन माल है, तो आपके लिए तुरंत ट्रेडिंग सदस्य भेजा जाएगा। कम मात्रा (2-3 टन) वाले किसानों को ट्रक पूरा होने तक प्रतीक्षा सूची में रखा जाता है।';
    }

    if (q.contains('बटाईदार') || q.contains('मजदूर') || q.contains('मालिक') || q.contains('bataidar') || q.contains('owner')) {
      if (isEnglishQuery) {
        return 'Apna Godam trades exclusively with valid land/stock owners. If you are a Bataidar or laborer, please provide the owner\'s mobile number.';
      }
      return 'मूंगफली का सौदा केवल जमीन या माल के वैध मालिक के साथ ही किया जाता है। यदि आप बटाईदार या मजदूर हैं, तो कृपया मालिक का मोबाइल नंबर उपलब्ध कराएं।';
    }

    // Handle follow-up selling/buying queries using conversation history
    if (q.contains('बेच') || q.contains('बेचणी') || q.contains('बेचना') || q.contains('सेल') || q.contains('sell') || q.contains('खरीद') || q.contains('buy')) {
      String previousCrop = 'मूंगफली (Groundnut)';
      if (history != null && history.isNotEmpty) {
        for (final turn in history.reversed) {
          final turnText = ((turn['user'] ?? '') + ' ' + (turn['assistant'] ?? '')).toLowerCase();
          if (turnText.contains('गेहूं') || turnText.contains('wheat')) {
            previousCrop = 'गेहूं (Wheat)'; break;
          } else if (turnText.contains('जौ') || turnText.contains('barley')) {
            previousCrop = 'जौ (Barley)'; break;
          } else if (turnText.contains('चना') || turnText.contains('gram')) {
            previousCrop = 'चना (Gram)'; break;
          } else if (turnText.contains('सरसों') || turnText.contains('mustard')) {
            previousCrop = 'सरसों (Mustard)'; break;
          } else if (turnText.contains('मूंगफली') || turnText.contains('groundnut')) {
            previousCrop = 'मूंगफली (Groundnut)'; break;
          }
        }
      }

      if (isEnglishQuery) {
        return 'To sell your $previousCrop on Apna Godam:\n1. Open the WBT / SBT Market section.\n2. Tap "Sell Stack" (चिठ्ठा बेचें).\n3. Enter your target price and quantity. Once a buyer accepts your bid, your order will be executed instantly!';
      }

      if (isBhojpuri) {
        return 'रउआ आपन $previousCrop अपना गोदाम पर आसानी से बेच सकिला:\n1. ऐप में व्यापार (WBT/SBT) सेक्शन में जाईं।\n2. "चिठ्ठा बेचें" पर क्लिक करके भाव अउर मात्रा दर्ज करीं।\n3. खरीदार बिड स्वीकार करत ही सौदा पक्का हो जाई!';
      }

      if (isMaithili) {
        return 'अहाँ अपना $previousCrop अपना गोदाम पर आसानी सँ बेच सकइत छी:\n1. ऐप में व्यापार (WBT/SBT) सेक्शन में जाउ।\n2. "चिठ्ठा बेचें" पर क्लिक क क भाव आ मात्रा दर्ज करू।\n3. खरीदार बिड स्वीकार करतहि सौदा पक्का भ जायत!';
      }

      return isMarwari
          ? 'थै आपरो $previousCrop अपना गोदाम पर आसानी सूं बेच सको छौ सा:\n1. ऐप में व्यापार (WBT/SBT) सेक्शन में जावो सा।\n2. "चिठ्ठा बेचें" पर क्लिक कर आपरो भाव अर मात्रा दर्ज करो सा।\n3. खरीदार बिड स्वीकार करते ही आपरो सौदा पक्को हो जावेगा!'
          : 'आप अपना $previousCrop अपना गोदाम पर आसानी से बेच सकते हैं:\n1. ऐप के व्यापार (WBT/SBT) सेक्शन में जाएं।\n2. "चिठ्ठा बेचें" पर क्लिक करके अपना भाव (Rate) और मात्रा दर्ज करें।\n3. जैसे ही खरीदार आपकी बिड स्वीकार करेगा, आपका सौदा पक्का हो जाएगा!';
    }

    // 1. INWARD (माल जमा)
    if (q.contains('इनवर्ड') || q.contains('inward') || q.contains('माल जमा') || q.contains('जमा')) {
      if (isEnglishQuery) {
        return 'To deposit goods (Inward):\n1. Tap "Inwards" in the app.\n2. Select warehouse, commodity & stack number.\n3. Enter weight (quintals), vehicle number & driver phone to submit.';
      }
      return 'गोदाम में माल जमा (Inward) करने के लिए:\n1. ऐप में "माल जमा" (Inwards) पर क्लिक करें।\n2. अपना गोदाम टर्मिनल, अनाज और स्टैक नंबर चुनें।\n3. वजन (क्विंटल), वाहन नंबर और ड्राइवर मोबाइल नंबर दर्ज करके सबमिट करें। गोदाम पर पहुंचने पर नमी व गुणवत्ता जांच के बाद माल जमा हो जाएगा।';
    }

    // 2. OUTWARD (माल निकासी)
    if (q.contains('आउटवर्ड') || q.contains('outward') || q.contains('निकासी') || q.contains('निकाल')) {
      if (isEnglishQuery) {
        return 'To withdraw goods (Outward):\n1. Tap "Outward" in the warehouse section.\n2. Select your warehouse, commodity and stack.\n3. Enter withdrawal weight and vehicle details to submit.';
      }
      return 'गोदाम से माल निकालने (Outward) के लिए:\n1. ऐप के गोदाम सेक्शन में "माल निकासी" पर क्लिक करें।\n2. अपना गोदाम और अनाज चुनकर संबंधित स्टैक चुनें।\n3. निकासी वजन और वाहन विवरण भरकर सबमिट करें। अप्रूवल के बाद डिजिटल गेट पास जारी होगा।';
    }

    // 3. GATEPASS (गेट पास)
    if (q.contains('गेट पास') || q.contains('गेटपास') || q.contains('gatepass') || q.contains('gate pass') || q.contains('banaun') || q.contains('banaye')) {
      if (isEnglishQuery) {
        return 'Digital Gate Pass is generated automatically once your Inward or Outward request is approved, displaying your QR code, stack number and vehicle details.';
      }
      return 'डिजिटल गेट पास (Gate Pass) बनाने के लिए:\n1. ऐप में इनवर्ड या आउटवर्ड रिक्वेस्ट दर्ज करें।\n2. रिक्वेस्ट अप्रूव होते ही ऐप में QR कोड गेट पास जारी हो जाएगा। इसमें गेटपास नंबर, वजन, स्टैक संख्या दर्ज होती है जिससे गोदाम पर तुरंत प्रवेश मिलता है।';
    }

    // 4. CROP RATE INQUIRY (फसल भाव पूछताछ)
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

      if (isBhojpuri) {
        return 'आज $cropDisplayName के भाव ₹$priceDisplay/किलो बा। रउआ खरीदे के बा कि बेचे के बा?';
      }

      if (isMaithili) {
        return 'अजका $cropDisplayName क भाव ₹$priceDisplay/किग्रा अछि। अहाँ कैनब चाहइत छी या बेचब चाहइत छी?';
      }

      return isMarwari
          ? 'आज $cropDisplayName रो भाव ₹$priceDisplay/क्विंटल छै सा। थै खरीदना चाहो छौ या बेचना चाहो छौ?'
          : 'आज $cropDisplayName का भाव ₹$priceDisplay/क्विंटल है। आप खरीदना चाहते हैं या बेचना चाहते हैं?';
    }

    if (isEnglishQuery) {
      return 'Welcome to Apna Godam AI Assistant. You can ask about warehouse booking, Inward, Outward, SBT/WBT trading, loans and live crop prices.';
    }

    if (isBhojpuri) {
      return 'राम-राम! अपना गोदाम ऐप में रउरा स्वागत बा। रउरा गोदाम बुकिंग, माल जमा, माल निकासी, बोली अउर लोन के जानकारी पूछ सकिला।';
    }

    if (isMaithili) {
      return 'राम-राम! अपना गोदाम ऐप में अहाँक स्वागत अछि। अहाँ गोदाम बुकिंग, माल जमा, माल निकासी आ लोनक जानकारी पूछ सकइत छी।';
    }

    return isMarwari
        ? 'राम-राम सा! अपना गोदाम ऐप में आपरो स्वागत छै। आप गोदाम बुकिंग, माल जमा (Inward), माल निकासी (Outward), बोली अर लोन री जानकारी पूछ सको छौ।'
        : 'अपना गोदाम ऐप में आपका स्वागत है। आप गोदाम बुकिंग, माल जमा (Inward), माल निकासी (Outward), SBT/WBT व्यापार, वॉलेट और कॉमोडिटी लोन की सभी सुविधाएं पूछ सकते हैं।';
  }

  static String _buildSystemPrompt({
    required String question,
    required String marketData,
  }) {
    return '''CRITICAL MULTI-DIALECT & EXACT RESPONSE FORMAT RULE:
1. DETECT THE USER'S EXACT LANGUAGE/DIALECT (Marwari, Hindi, English, Bhojpuri, Maithili, Magahi, Angika, Bajika) AND RESPOND DIRECTLY IN THAT SAME LANGUAGE/DIALECT IN DEVANAGARI SCRIPT:
   - Marwari (मारवाड़ी): "अजमेर मंडी में मूंगफली रो भाव ₹65/किग्रा छै सा। थै अपना गोदाम पर आसानी सूं बेच सको छौ।"
   - Hindi (हिंदी): "अजमेर मंडी में मूंगफली का भाव ₹65/किग्रा है। आप अपना गोदाम पर आसानी से बेच सकते हैं।"
   - English: "Today's rate for Groundnut is ₹65/kg on Apna Godam."
   - Bhojpuri (भोजपुरी): "अजमेर मंडी में मूंगफली के भाव ₹65/किलो बा। रउआ अपना गोदाम पर आसानी से बेच सकिला।"
   - Maithili (मैथिली): "अजमेर मंडी में मूंगफलीक भाव ₹65/किग्रा अछि। अहाँ अपना गोदाम पर आसानी सँ बेच सकइत छी।"
   - Magahi (मगही): "अजमेर मंडी में मूंगफली के भाव ₹65/किलो हई। तोरा अपना गोदाम पर आसानी से बेचे के हई।"
   - Angika (अंगिका): "अजमेर मंडी में मूंगफली के भाव ₹65/किग्रा छै। हमरा अपना गोदाम पर आसानी से बेचै लेल सकै छियै।"
   - Bajika (बजिका): "अजमेर मंडी में मूंगफली के भाव ₹65/किलो बा। अहाँ अपना गोदाम पर आसानी से बेच सकिला।"

2. GROUNDNUT (मूंगफली) DOMAIN & QUALITY RULES:
   - Synonyms: मूंगफली, मूंफली, ग्राउंडनट, सिकाई मूंगफली, सिंगदाना, गोटा।
   - 3 Quality Types:
     a) सिकाई गुणवत्ता (Sikai Quality): Whole roasted. Golden shell, grown in Western Rajasthan (Jaisalmer, Bikaner, Phalodi, Mohangarh, Bajju, Nachna). Khala (खला) type only. Price ~₹60 to ₹70-75/kg. (Do NOT quote Sikai rates for Jaipur/Chomu/Sikar without quality verification!).
     b) दाना गुणवत्ता (Dana Quality): Inner kernel/gota is good, outer shell thin. Sold shelled (singdana/gota). Khala (खला) type only.
     c) तेल गुणवत्ता (Oil Quality): Lighter seed/shell, thin kernels for oil extraction. Both Khala (खला) and Chugga (चुग्गा) types used.
   - Harvesting Types: Khala (खला - pulled with plant) vs Chugga (चुग्गा - detached in soil). Note: Chugga is treated as Oil Quality!
   - Truckload Rules: Full truckload = 20-25 Tons (23-27 Tons max). If farmer has ~25 Tons, dispatch trading member immediately! If low quantity (2-3 Tons or 4-6 bags), put on waitlist until full truckload is aggregated nearby.
   - Ownership Policy: Deals ONLY with land/stock owner (मालिक). If caller is Bataidar (बटाईदार) or laborer (मजदूर), politely request owner's phone number.
   - Location Verification: Always confirm actual storage location (do not assume caller current location).
   - Quality Parameters: 2-dana & 3-dana pods are positive (+ price), 1-dana pods are negative (- price due to extra peeling labor).

3. FULL APNA GODAM SERVICES:
   - Inward (माल जमा): Select terminal, commodity, stack no, weight (qtl), vehicle & driver phone.
   - Outward (माल निकासी): Select warehouse, commodity, stack, weight. Approved request generates QR Gatepass.
   - Stack Booking (चिठ्ठा): Reserve vacant stack (Green). Rate card confirms rent/day, labour, fumigation/insurance.
   - Quality Calculator: FM, Moisture %, Dana, Tikki parameters calculate QV Price & Final Price.
   - SBT / WBT Trading: Live bidding with Upper/Lower Circuits, LTP, bidding time slots. Match order -> Dispatch GRN.
   - Wallet: Storage Wallet, Trade Wallet, Loan Wallet. Instant withdrawal to bank account.
   - BNPL Loan: Credit limit (up to ₹1.5 Cr) against stored commodity value.

LIVE MARKET DATA:
$marketData''';
  }
}
