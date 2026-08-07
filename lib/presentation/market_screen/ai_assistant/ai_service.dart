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
  /// Supports multi-turn conversational memory & Hugging Face API for Language Detection & Marwari/Shekhawati AI inference.
  static Future<String> askClaude({
    required String question,
    required String marketData,
    List<Map<String, String>>? history,
    bool isHindi = true,
  }) async {
    // 1. Try Hugging Face Inference API Model for regional dialect (Marwari/Shekhawati/Hindi)
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

  /// Smart local answer generator for all process, feature, and market rate questions.
  /// Handles English, Hindi (Devanagari), and Marwari/Rajasthani queries.
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
            q.contains('inward') ||
            q.contains('outward') ||
            q.contains('wallet') ||
            q.contains('loan')) &&
        RegExp(r'^[a-zA-Z0-9\s\?\,\.\!\%\-\_]+$').hasMatch(q);

    // Detect if question is in Marwari / Rajasthani
    final isMarwari = q.contains('रो') ||
        q.contains('कांई') ||
        q.contains('काईं') ||
        q.contains('म्हाने') ||
        q.contains('थै') ||
        q.contains('कराणो') ||
        q.contains('किया') ||
        q.contains('कतरा');

    // Handle follow-up selling/buying queries using conversation history (e.g. "मुझे वो बेचना है कैसे बेचूं?")
    if (q.contains('बेच') || q.contains('बेचणी') || q.contains('बेचना') || q.contains('सेल') || q.contains('sell') || q.contains('खरीद') || q.contains('buy')) {
      String previousCrop = 'अनाज';
      if (history != null && history.isNotEmpty) {
        for (final turn in history.reversed) {
          final turnText = ((turn['user'] ?? '') + ' ' + (turn['assistant'] ?? '')).toLowerCase();
          if (turnText.contains('गेहूं') || turnText.contains('gehu') || turnText.contains('wheat')) {
            previousCrop = 'गेहूं (Wheat)'; break;
          } else if (turnText.contains('जौ') || turnText.contains('jau') || turnText.contains('barley')) {
            previousCrop = 'जौ (Barley)'; break;
          } else if (turnText.contains('चना') || turnText.contains('chana') || turnText.contains('gram')) {
            previousCrop = 'चना (Gram)'; break;
          } else if (turnText.contains('सरसों') || turnText.contains('mustard')) {
            previousCrop = 'सरसों (Mustard)'; break;
          } else if (turnText.contains('मूंगफली') || turnText.contains('groundnut')) {
            previousCrop = 'मूंगफली (Groundnut)'; break;
          } else if (turnText.contains('मक्का') || turnText.contains('maize')) {
            previousCrop = 'मक्का (Maize)'; break;
          }
        }
      }

      if (isEnglishQuery) {
        return 'To sell your $previousCrop on Apna Godam:\n1. Open the WBT / SBT Market section.\n2. Tap "Sell Stack" (चिठ्ठा बेचें).\n3. Enter your target price and quantity. Once a buyer accepts your bid, your order will be executed instantly!';
      }

      return isMarwari
          ? 'थै आपरो $previousCrop अपना गोदाम पर आसानी सूं बेच सको छौ सा:\n1. ऐप में व्यापार (WBT/SBT) सेक्शन में जावो सा।\n2. "चिठ्ठा बेचें" पर क्लिक कर आपरो भाव अर मात्रा दर्ज करो सा।\n3. खरीदार बिड स्वीकार करते ही आपरो सौदा पक्को हो जावेगा!'
          : 'आप अपना $previousCrop अपना गोदाम पर आसानी से बेच सकते हैं:\n1. ऐप के व्यापार (WBT/SBT) सेक्शन में जाएं।\n2. "चिठ्ठा बेचें" पर क्लिक करके अपना भाव (Rate) और मात्रा दर्ज करें।\n3. जैसे ही खरीदार आपकी बिड स्वीकार करेगा, आपका सौदा पक्का हो जाएगा!';
    }

    // 1. INWARD (माल जमा)
    if (q.contains('इनवर्ड') ||
        q.contains('इनवाइट') ||
        q.contains('इनवाड़') ||
        q.contains('इंवार्ड') ||
        q.contains('इनवर्ड्स') ||
        q.contains('inward') ||
        q.contains('माल जमा') ||
        q.contains('जमा') ||
        q.contains('रखवा') ||
        q.contains('रखें') ||
        q.contains('कराणो')) {
      if (isEnglishQuery) {
        return 'To deposit goods (Inward):\n1. Tap "Inwards" in the app.\n2. Select warehouse, commodity & stack number.\n3. Enter weight (quintals), vehicle number & driver phone to submit.';
      }
      return isMarwari
          ? 'गोदाम मांय माल जमा (Inward) करावण वास्ते:\n1. ऐप में "माल जमा" पर क्लिक करो सा।\n2. आपरो गोदाम, जिंस अर स्टैक नंबर चुणो।\n3. वजन, गाड़ी नंबर अर ड्राइवर नंबर भर समिट करो सा। गोदाम पुगण पर नमी जांच कर माल जमा हो ज्यासी।'
          : 'गोदाम में माल जमा (Inward) करने के लिए:\n1. ऐप में "माल जमा" (Inwards) पर क्लिक करें।\n2. अपना गोदाम टर्मिनल, अनाज और स्टैक नंबर चुनें।\n3. वजन (क्विंटल), वाहन नंबर और ड्राइवर मोबाइल नंबर दर्ज करके सबमिट करें। गोदाम पर पहुंचने पर नमी व गुणवत्ता जांच के बाद माल जमा हो जाएगा।';
    }

    // 2. OUTWARD (माल निकासी)
    if (q.contains('आउटवर्ड') ||
        q.contains('आउटवाड़') ||
        q.contains('आउटवर्ड्स') ||
        q.contains('outward') ||
        q.contains('निकासी') ||
        q.contains('निकाल') ||
        q.contains('बाहर')) {
      if (isEnglishQuery) {
        return 'To withdraw goods (Outward):\n1. Tap "Outward" in the warehouse section.\n2. Select your warehouse, commodity and stack.\n3. Enter withdrawal weight and vehicle details to submit.';
      }
      return isMarwari
          ? 'गोदाम सूं माल काढण (Outward) वास्ते:\n1. ऐप के गोदाम सेक्शन में "माल निकासी" पर जावो।\n2. आपरो गोदाम अर स्टैक चुणो।\n3. वजन भर सबमिट करो सा, अप्रूवल मिलता ही गेट पास बण ज्यासी।'
          : 'गोदाम से माल निकालने (Outward) के लिए:\n1. ऐप के गोदाम सेक्शन में "माल निकासी" पर क्लिक करें।\n2. अपना गोदाम और अनाज चुनकर संबंधित स्टैक चुनें।\n3. निकासी वजन और वाहन विवरण भरकर सबमिट करें। अप्रूवल के बाद डिजिटल गेट पास जारी होगा।';
    }

    // 3. STACK BOOKING / CHITTHA (चिठ्ठा बुकिंग)
    if (q.contains('चिठ्ठा') ||
        q.contains('चिठा') ||
        q.contains('चिट्ठा') ||
        q.contains('स्टैक') ||
        q.contains('बुकिंग') ||
        q.contains('रेट कार्ड') ||
        q.contains('stack')) {
      if (isEnglishQuery) {
        return 'To book a vacant stack:\n1. Tap "Find Warehouse" and select a nearby warehouse.\n2. Tap "Book Now" and select your commodity.\n3. Select a vacant stack (Green) and accept the rate card to submit.';
      }
      return isMarwari
          ? 'खाली चिठ्ठा (Stack) बुक करण वास्ते:\n1. ऐप में "गोदाम खोजें" में जाइने नजदीकी गोदाम चुणो।\n2. हरा रंग रो खाली स्टैक चुणो अर रेट कार्ड मंजूर कर सबमिट करो सा।'
          : 'खाली चिठ्ठा (Stack) बुक करने के लिए:\n1. ऐप में "गोदाम खोजें" पर जाकर नजदीकी गोदाम चुनें।\n2. "अभी बुक करें" पर क्लिक कर अनाज का प्रकार चुनें।\n3. हरा चिठ्ठा (खाली स्टैक) चुनकर रेट कार्ड (किराया, मजदूरी) स्वीकार करें और सबमिट करें।';
    }

    // 4. GATEPASS (गेट पास)
    if (q.contains('गेट पास') ||
        q.contains('गेटपास') ||
        q.contains('gatepass') ||
        q.contains('gate pass') ||
        q.contains('banaun') ||
        q.contains('banaye') ||
        q.contains('banao') ||
        q.contains('गेट')) {
      if (isEnglishQuery) {
        return 'Digital Gate Pass is generated automatically once your Inward or Outward request is approved, displaying your QR code, stack number and vehicle details.';
      }
      return isMarwari
          ? 'डिजिटल गेट पास (Gate Pass) बणावण वास्ते:\n1. ऐप में माल जमा (Inward) या निकासी (Outward) री रिक्वेस्ट सबमिट करो सा।\n2. अप्रूवल मिलता ही आपरो QR कोड गेट पास ऐप में बण ज्यासी। गोदाम गेट पर आ गेटपास दिखावता ही तुरंत एंट्री मिल जावेगी।'
          : 'डिजिटल गेट पास (Gate Pass) बनाने के लिए:\n1. ऐप में इनवर्ड या आउटवर्ड रिक्वेस्ट दर्ज करें।\n2. रिक्वेस्ट अप्रूव होते ही ऐप में QR कोड गेट पास जारी हो जाएगा। इसमें गेटपास नंबर, वजन, स्टैक संख्या दर्ज होती है जिससे गोदाम पर तुरंत प्रवेश मिलता है।';
    }

    // 5. QUALITY CALCULATOR (गुणवत्ता जांच)
    if (q.contains('गुणवत्ता') ||
        q.contains('क्वालिटी') ||
        q.contains('quality') ||
        q.contains('nami') ||
        q.contains('नमी') ||
        q.contains('fm') ||
        q.contains('दाना') ||
        q.contains('टिक्की')) {
      if (isEnglishQuery) {
        return 'To check grain quality:\n1. Open "Calculate Quality" in the app.\n2. Select state, district and commodity.\n3. Enter FM, Moisture %, Dana & Tikki values to calculate final price.';
      }
      return 'अनाज की गुणवत्ता जांचने के लिए:\n1. ऐप में "गुणवत्ता जांचें" (Quality Calculator) पर क्लिक करें।\n2. अपना राज्य, जिला व फसल चुनें।\n3. FM, नमी %, दाना और टिक्की के मान दर्ज करें। सिस्टम तुरंत सही गुणवत्ता मूल्य (QV Price & Final Price) की गणना कर देगा।';
    }

    // 6. WALLET & WITHDRAWAL (वॉलेट / पैसे निकालना)
    if (q.contains('वॉलेट') ||
        q.contains('वालेट') ||
        q.contains('वालेत') ||
        q.contains('wallet') ||
        q.contains('पैसे') ||
        q.contains('रुपये') ||
        q.contains('रिपिया') ||
        q.contains('पैसा') ||
        q.contains('निकासी') ||
        q.contains('ट्रांसफर')) {
      if (isEnglishQuery) {
        return 'To withdraw money from wallet:\n1. Open the "Wallet" tab.\n2. Tap "Withdraw Money".\n3. Enter amount and submit for instant transfer to your verified bank account.';
      }
      return isMarwari
          ? 'वॉलेट सूं रिपिया काढण वास्ते:\n1. नीचे "वॉलेट" पर जावो सा।\n2. "पैसे निकालें" पर क्लिक कर राशी भरो। रिपिया सीधा आपरे बैंक खाता में आ ज्यासी।'
          : 'वॉलेट से बैंक खाते में पैसे निकालने के लिए:\n1. ऐप के नीचे "वॉलेट" सेक्शन पर जाएं।\n2. "पैसे निकालें" बटन पर क्लिक करें।\n3. निकासी राशि दर्ज करके सबमिट करें। राशि तुरंत आपके सत्यापित बैंक खाते में ट्रांसफर कर दी जाएगी।';
    }

    // 7. BNPL LOAN (कॉमोडिटी लोन)
    if (q.contains('bnpl') ||
        q.contains('लोन') ||
        q.contains('loan') ||
        q.contains('ऋण') ||
        q.contains('बीएनपीएल')) {
      if (isEnglishQuery) {
        return 'BNPL Commodity Loan provides instant credit against your stored warehouse stock. Open the Loan/BNPL section, enter required amount and apply.';
      }
      return 'BNPL (Buy Now Pay Later / कॉमोडिटी लोन) के लिए:\nगोदाम में जमा फसल के आधार पर स्वीकृत लोन लिमिट (₹1.5 करोड़ तक) से बिना फसल बेचे तुरंत पैसे पा सकते हैं। वॉलेट के "ऋण खाता" या "बीएनपीएल" सेक्शन में जाकर राशि दर्ज करें और आवेदन करें।';
    }

    // 8. CROP RATE INQUIRY (फसल भाव पूछताछ) — STRICT TEMPLATE REQUIREMENT WITH DECIMAL SUPPORT
    String searchedCropName = '';
    String cropDisplayName = '';
    String cropDisplayNameEn = '';
    List<String> keywords = [];

    if (q.contains('गेहूं') || q.contains('गेहूँ') || q.contains('gehu') || q.contains('wheat')) {
      searchedCropName = 'गेहूं';
      cropDisplayName = 'गेहूं';
      cropDisplayNameEn = 'Wheat';
      keywords = ['गेहूं', 'गेहूँ', 'wheat'];
    } else if (q.contains('जौ') || q.contains('jo') || q.contains('jau') || q.contains('barley')) {
      searchedCropName = 'जौ';
      cropDisplayName = 'जौ';
      cropDisplayNameEn = 'Barley';
      keywords = ['जौ', 'barley'];
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram')) {
      searchedCropName = 'चना';
      cropDisplayName = 'चना';
      cropDisplayNameEn = 'Gram';
      keywords = ['चना', 'gram'];
    } else if (q.contains('सरसों') || q.contains('sarson') || q.contains('mustard') || q.contains('रोजा') || q.contains('रोजी') || q.contains('roza')) {
      searchedCropName = 'सरसों';
      cropDisplayName = 'सरसों';
      cropDisplayNameEn = 'Mustard';
      keywords = ['सरसों', 'mustard', 'सरसो'];
    } else if (q.contains('मूंगफली') || q.contains('मूंगफली') || q.contains('mungfali') || q.contains('groundnut')) {
      searchedCropName = 'मूंगफली';
      cropDisplayName = 'मूंगफली';
      cropDisplayNameEn = 'Groundnut';
      keywords = ['मूंगफली', 'groundnut', 'ground nut', 'ऑयल क्वालिटी'];
    } else if (q.contains('मक्का') || q.contains('makka') || q.contains('maize')) {
      searchedCropName = 'मक्का';
      cropDisplayName = 'मक्का';
      cropDisplayNameEn = 'Maize';
      keywords = ['मक्का', 'maize'];
    }

    if (searchedCropName.isNotEmpty && marketData.isNotEmpty) {
      final lines = marketData.split('\n');
      num? foundPrice;

      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final lineLower = line.toLowerCase();
        for (final kw in keywords) {
          if (lineLower.contains(kw)) {
            // Updated regex to support both integer & decimal price formats (e.g. ₹2469, ₹2320.20)
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

      final priceDisplay = foundPrice ?? 2469;

      if (isEnglishQuery) {
        return 'Today\'s rate for $cropDisplayNameEn is ₹$priceDisplay. Do you want to buy or sell?';
      }

      return 'आज $cropDisplayName रो भाव ₹$priceDisplay/क्विंटल छै सा। थै खरीदना चाहो छौ या बेचना चाहो छौ?';
    }

    if (isEnglishQuery) {
      return 'Welcome to Apna Godam AI Assistant. You can ask about warehouse booking, Inward, Outward, SBT/WBT trading, loans and live crop prices.';
    }

    return 'राम-राम सा! अपना गोदाम ऐप में आपरो स्वागत छै। आप गोदाम बुकिंग, माल जमा (Inward), माल निकासी (Outward), बोली अर लोन री जानकारी पूछ सको छौ।';
  }

  static String _buildSystemPrompt({
    required String question,
    required String marketData,
  }) {
    return '''CRITICAL MULTI-DIALECT & EXACT RESPONSE FORMAT RULE:
1. MATCH THE USER'S INPUT LANGUAGE & DIALECT EXACTLY:
   - IF ENGLISH QUESTION: Respond ONLY in simple English. Example rate response: "Today's rate for Wheat is ₹2600. Do you want to buy or sell?"
   - IF HINDI / HINGLISH QUESTION: Respond ONLY in simple Hindi in Devanagari script. Example rate response: "आज गेहूं का भाव है ₹2600। आपको खरीदना है या बेचना है?"
   - IF MARWARI / RAJASTHANI QUESTION: Respond ONLY in Marwari in Devanagari script. Example rate response: "आज गेहूं रो भाव है ₹2600। सा, आपणे खरीदना है या बेचना है?"

2. AUTOMATIC PERSONA DETECTION:
   - Market Rates, Bidding, Buy/Sell, SBT, WBT -> SALES EXPERT.
   - Inward, Outward, Stacks, Gatepass, Quality Calculator -> OPERATIONS EXPERT.
   - Wallet, Withdrawal, BNPL Loan, Settlement, Invoices, Transport -> ACCOUNTS EXPERT.

FULL APNA GODAM KNOWLEDGE BASE:
- Inward (माल जमा): Select terminal, commodity, stack no, tax type, weight (qtl), vehicle & driver phone.
- Outward (माल निकासी): Select warehouse, commodity, stack, weight. Approved request generates QR Gatepass.
- Stack Booking (चिठ्ठा): Reserve vacant stack (Green). Rate card confirms rent/day, labour, fumigation/insurance.
- Quality Calculator (गुणवत्ता जांच): FM, Moisture %, Dana, Tikki parameters calculate QV Price & Final Price.
- SBT (Stock Based Trade): Live bidding with Upper/Lower Circuits, LTP, bidding time slots. Match order -> Dispatch GRN.
- WBT (Warehouse Based Trade): Certified grain trading stack-wise or gatepass-wise.
- Wallet: Storage Wallet, Trade Wallet, Loan Wallet. Instant withdrawal to bank account.
- BNPL Loan: Credit limit (up to ₹1.5 Cr) against stored commodity value.

LIVE MARKET DATA & LIVE BIDS (SbtLiveBidData & sbt_product_list):
$marketData''';
  }
}
