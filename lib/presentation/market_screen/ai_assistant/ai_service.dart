import 'dart:convert';
import 'package:apnagodam/core/config/app_config.dart';
import 'package:http/http.dart' as http;

/// The 3 AI model personas available to the farmer
enum AiModel {
  operations,
  sales,
  accounts,
}

class AiService {
  static const String _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const List<String> _modelsToTry = [
    'claude-3-5-sonnet-latest',
    'claude-3-5-haiku-latest',
    'claude-3-haiku-20240307',
    'claude-3-sonnet-20240229',
    'claude-3-5-sonnet-20241022',
  ];

  /// Sends a farmer's question to Claude with live market data as context.
  static Future<String> askClaude({
    required String question,
    required AiModel model,
    required String intent,
    required String marketData,
    required bool isHindi,
  }) async {
    final systemPrompt = _buildSystemPrompt(
      model: model,
      intent: intent,
      marketData: marketData,
      isHindi: isHindi,
    );

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
            'messages': [
              {'role': 'user', 'content': question},
            ],
          }),
        );

        print('Claude API ($modelName) status: ${response.statusCode}');
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['content'][0]['text'] as String;
        } else {
          print('Claude API ($modelName) body: ${response.body}');
        }
      } catch (e) {
        print('Claude API ($modelName) exception: $e');
      }
    }

    // If all API calls fail or return error, use smart local market fallback
    return _fallbackMarketResponse(question, marketData);
  }

  /// Smart local answer generator for all process, feature, and market rate questions.
  static String _fallbackMarketResponse(String question, String marketData) {
    final q = question.toLowerCase().trim();

    // 1. INWARD (माल जमा)
    if (q.contains('इनवर्ड') || q.contains('inward') || q.contains('माल जमा') || (q.contains('जमा') && q.contains('कैसे')) || q.contains('माल कैसे रख')) {
      return 'गोदाम में माल जमा (Inward) करने के लिए:\n1. ऐप में "माल जमा" (Inwards) पर क्लिक करें।\n2. अपना गोदाम टर्मिनल, अनाज और स्टैक नंबर चुनें।\n3. वजन (क्विंटल), वाहन नंबर और ड्राइवर मोबाइल नंबर दर्ज करके सबमिट करें। गोदाम पर पहुंचने पर नमी व गुणवत्ता जांच के बाद माल जमा हो जाएगा।';
    }

    // 2. OUTWARD (माल निकासी)
    if (q.contains('आउटवर्ड') || q.contains('outward') || q.contains('माल निकासी') || q.contains('निकासी कैसे') || q.contains('माल बाहर') || q.contains('स्टॉक निकाल')) {
      return 'गोदाम से माल निकालने (Outward) के लिए:\n1. ऐप के गोदाम सेक्शन में "माल निकासी" पर क्लिक करें।\n2. अपना गोदाम और अनाज चुनकर संबंधित स्टैक चुनें।\n3. निकासी वजन और वाहन विवरण भरकर सबमिट करें। अप्रूवल के बाद डिजिटल गेट पास जारी होगा।';
    }

    // 3. STACK BOOKING / CHITTHA (चिठ्ठा बुकिंग)
    if (q.contains('चिठ्ठा') || q.contains('स्टैक') || q.contains('stack') || q.contains('बुकिंग') || q.contains('रेट कार्ड')) {
      return 'खाली चिठ्ठा (Stack) बुक करने के लिए:\n1. ऐप में "गोदाम खोजें" पर जाकर नजदीकी गोदाम चुनें।\n2. "अभी बुक करें" पर क्लिक कर अनाज का प्रकार चुनें।\n3. हरा चिठ्ठा (खाली स्टैक) चुनकर रेट कार्ड (किराया, मजदूरी) स्वीकार करें और सबमिट करें।';
    }

    // 4. GATEPASS (गेट पास)
    if (q.contains('गेट पास') || q.contains('गेटपास') || q.contains('gatepass') || q.contains('qr')) {
      return 'डिजिटल गेट पास (Gate Pass) के बारे में:\nइनवर्ड या आउटवर्ड अप्रूवल के बाद ऐप में डिजिटल QR गेट पास जनरेट होता है। इसमें गेटपास नंबर, वजन, स्टैक संख्या और वाहन नंबर दर्ज होता है जिससे गोदाम गेट पर तुरंत प्रवेश मिलता है।';
    }

    // 5. QUALITY CALCULATOR (गुणवत्ता जांच)
    if (q.contains('गुणवत्ता') || q.contains('quality') || q.contains('nami') || q.contains('नमी') || q.contains('fm') || q.contains('dana') || q.contains('tikki')) {
      return 'अनाज की गुणवत्ता जांचने के लिए:\n1. ऐप में "गुणवत्ता जांचें" (Quality Calculator) पर क्लिक करें।\n2. अपना राज्य, जिला व फसल चुनें।\n3. FM, नमी %, दाना और टिक्की के मान दर्ज करें। सिस्टम तुरंत सही गुणवत्ता मूल्य (QV Price & Final Price) की गणना कर देगा।';
    }

    // 6. SBT TRADING (एसबीटी व्यापार / बोली)
    if (q.contains('sbt') || q.contains('एसबीटी') || q.contains('बोली कैसे') || q.contains('सर्किट') || q.contains('ऑर्डर')) {
      return 'SBT (Stock Based Trade) में बोली लगाने के लिए:\n1. ऐप के "व्यापार" सेक्शन में SBT चुनें।\n2. अपनी फसल व फैक्ट्री/गोदाम चुनकर "ऑर्डर जोड़ें" पर क्लिक करें।\n3. लोअर व अपर सर्किट के बीच भाव और मात्रा (क्विंटल) दर्ज करके सबमिट करें। भाव मैच होते ही सौदा पूरा होगा।';
    }

    // 7. WBT TRADING (डब्ल्यूबीटी व्यापार)
    if (q.contains('wbt') || q.contains('डब्लूबीटी') || q.contains('डब्ल्यूबीटी')) {
      return 'WBT (Warehouse Based Trade) में व्यापार करने के लिए:\nगोदाम में जमा प्रमाणित अनाज पर "चिठ्ठा अनुसार" या "गेटपास अनुसार" ओपन स्टॉक देखें। "बोली लगाएं" पर क्लिक करके अपना खरीद/बिक्री भाव दर्ज करें।';
    }

    // 8. F2F DEALS (फेस टू फेस डील्स)
    if (q.contains('f2f') || q.contains('फेस टू फेस') || q.contains('face to face') || q.contains('स्कैन')) {
      return 'Face to Face (F2F) डील करने के लिए:\n1. सेलर ऐप में अनाज, मूल्य और वजन दर्ज करके "बेचना" चुनता है और QR कोड जनरेट करता है।\n2. बायर अपने ऐप से वह QR कोड स्कैन करता है, फोटो चुनकर सबमिट करता है और सौदा तुरंत पूरा हो जाता है।';
    }

    // 9. WALLET & WITHDRAWAL (वॉलेट / पैसे निकालना)
    if (q.contains('वॉलेट') || q.contains('wallet') || q.contains('पैसे निकाल') || q.contains('withdraw') || q.contains('बैंक ट्रांसफर') || q.contains('पैसे जोड़')) {
      return 'वॉलेट से बैंक खाते में पैसे निकालने के लिए:\n1. ऐप के नीचे "वॉलेट" सेक्शन पर जाएं।\n2. "पैसे निकालें" बटन पर क्लिक करें।\n3. निकासी राशि दर्ज करके सबमिट करें। राशि तुरंत आपके सत्यापित बैंक खाते में ट्रांसफर कर दी जाएगी।';
    }

    // 10. BNPL LOAN (कॉमोडिटी लोन)
    if (q.contains('bnpl') || q.contains('लोन') || q.contains('loan') || q.contains('ऋण')) {
      return 'BNPL (Buy Now Pay Later / कॉमोडिटी लोन) के लिए:\nगोदाम में जमा फसल के आधार पर स्वीकृत लोन लिमिट (₹1.5 करोड़ तक) से बिना फसल बेचे तुरंत पैसे पा सकते हैं। वॉलेट के "ऋण खाता" या "बीएनपीएल" सेक्शन में जाकर राशि दर्ज करें और आवेदन करें।';
    }

    // 11. REPAYMENT (पुनर्भुगतान)
    if (q.contains('पुनर्भुगतान') || q.contains('repayment') || q.contains('ऋण भुगतान') || q.contains('बकाया')) {
      return 'ऋण का पुनर्भुगतान करने के लिए:\nहोम पेज पर "पुनर्भुगतान" बटन पर क्लिक करें। अपना गोदाम, अनाज और स्टैक नंबर चुनकर बकाया राशि, ब्याज व किराया देखें और वॉलेट द्वारा तुरंत भुगतान करें।';
    }

    // 12. INVOICES / BILLS (बिल / इनवॉइस)
    if (q.contains('बिल') || q.contains('bill') || q.contains('invoice') || q.contains('इनवॉइस') || q.contains('सौदा पर्ची')) {
      return 'अपने बिल देखने के लिए:\nऐप में "बिल" सेक्शन पर जाएं। "मेरे द्वारा उठाए गए बिल" या "मुझसे उठाए गए बिल" में सौदा पर्ची, टैक्स इनवॉइस और कुल भुगतान विवरण देखें व डाउनलोड करें।';
    }

    // 13. TRANSPORT (परिवहन)
    if (q.contains('परिवहन') || q.contains('transport') || q.contains('पिक अप') || q.contains('ड्रॉप') || q.contains('गाड़ी')) {
      return 'परिवहन बुक करने के लिए:\nप्रोफाइल मेनू से "परिवहन पिक-अप" या "ड्रॉप" चुनें। पिक-अप स्थान, डिलीवरी स्थान, अनाज, पाने वाले का नाम/नंबर और गाड़ी भाड़ा भरकर ट्रिप आईडी बनाएं।';
    }

    // 14. CROP RATE INQUIRY (फसल भाव पूछताछ)
    String searchedCropName = '';
    List<String> keywords = [];

    if (q.contains('गेहूं') || q.contains('gehu') || q.contains('wheat')) {
      searchedCropName = 'गेहूं (Wheat)';
      keywords = ['गेहूं', 'wheat'];
    } else if (q.contains('जौ') || q.contains('jo') || q.contains('jau') || q.contains('barley')) {
      searchedCropName = 'जौ (Barley)';
      keywords = ['जौ', 'barley'];
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram')) {
      searchedCropName = 'चना (Gram)';
      keywords = ['चना', 'gram'];
    } else if (q.contains('सरसों') || q.contains('sarson') || q.contains('mustard')) {
      searchedCropName = 'सरसों (Mustard)';
      keywords = ['सरसों', 'mustard'];
    } else if (q.contains('मूंगफली') || q.contains('mungfali') || q.contains('groundnut')) {
      searchedCropName = 'मूंगफली (Groundnut)';
      keywords = ['मूंगफली', 'groundnut'];
    } else if (q.contains('मक्का') || q.contains('makka') || q.contains('maize')) {
      searchedCropName = 'मक्का (Maize)';
      keywords = ['मक्का', 'maize'];
    }

    if (marketData.isNotEmpty) {
      final lines = marketData.split('\n');
      final matchedLines = <String>[];

      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final lineLower = line.toLowerCase();
        if (keywords.isNotEmpty) {
          for (final kw in keywords) {
            if (lineLower.contains(kw)) {
              matchedLines.add(line.trim());
              break;
            }
          }
        }
      }

      if (matchedLines.isNotEmpty) {
        return 'आज के $searchedCropName का लाइव बाजार भाव:\n${matchedLines.take(3).join('\n')}';
      }

      if (searchedCropName.isNotEmpty) {
        return 'आज के लाइव बाजार डेटा में $searchedCropName का भाव/बोली उपलब्ध नहीं है। कृपया ऐप का व्यापार (SBT/WBT) सेक्शन देखें।';
      }

      final topRates = lines.where((l) => l.contains('₹') || l.contains('फसल:')).take(3).join('\n');
      if (topRates.isNotEmpty) {
        return 'आज के मुख्य लाइव बाजार भाव:\n$topRates';
      }
    }

    return 'अपना गोदाम ऐप में गोदाम बुकिंग, माल जमा (Inward), माल निकासी (Outward), SBT/WBT व्यापार, वॉलेट और कॉमोडिटी लोन की सभी सुविधाएं उपलब्ध हैं।';
  }

  static String _buildSystemPrompt({
    required AiModel model,
    required String intent,
    required String marketData,
    required bool isHindi,
  }) {
    const langInstruction = '''CRITICAL LANGUAGE RULE:
- You MUST ALWAYS respond in simple, polite HINDI using DEVANAGARI script (देवनागरी हिंदी).
- Even if the user speaks or types in Roman Hindi / Hinglish (for example: "aaj jo ka bhav ky h", "inward kaise kare", "wallet se paise kaise nikale"), you MUST reply ONLY in Hindi Devanagari script.
- Never reply in English unless explicitly asked.
- Keep responses short, accurate, and easy to understand for farmers (2-3 sentences max).''';

    final intentContext = intent == 'buy'
        ? 'किसान खरीदना चाहता है (Buyer Query)'
        : (intent == 'sell'
            ? 'किसान बेचना चाहता है (Seller Query)'
            : 'सामान्य पूछताछ (General Query)');

    String roleDescription;
    String knowledgeBase;

    switch (model) {
      case AiModel.operations:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ ऑपरेशन विशेषज्ञ (Operations & Godown Expert) हैं। आप ऐप के गोदाम समाधान (Warehousing Solutions) जैसे गोदाम खोजना, चिठ्ठा (Stack Booking), इनवर्ड (Inwards), आउटवर्ड (Outwards), गुणवत्ता जांच (Quality Calculation) और गेटपास की पूरी जानकारी देते हैं।''';
        knowledgeBase = '''अपना गोदाम ऐप ऑपरेशन नियम एवं रोडमैप (Operations Roadmap & Features):
1. गोदाम खोजें (Find Warehouse): होम पेज या गोदाम सेक्शन से दूरी, भंडारण क्षमता और मैप लोकेशन के आधार पर नजदीकी गोदाम खोज सकते हैं।
2. चिठ्ठा बुकिंग (Stack Booking): खाली स्टैक (हरा रंग = खाली, लाल रंग = आरक्षित) चुनकर अनाज जमा करने की प्रक्रिया शुरू करें। रेट कार्ड में किराया/दिन, मजदूरी और शर्ते (Fumigation & Insurance) पुष्टि करके जमा करें।
3. माल जमा (Inwards): गोदाम, अनाज, स्टैक नंबर, टैक्स का प्रकार, वजन (क्विंटल में), वाहन का प्रकार/नंबर और ड्राइवर मोबाइल नंबर दर्ज करके जमा करें। "पुराना विवरण" बटन से पुराना इनवर्ड स्टेटस देख सकते हैं।
4. माल निकासी (Outwards): गोदाम और अनाज चुनकर निकासी योग्य स्टैक चुनें, मात्रा भरें और आउटवर्ड रिक्वेस्ट सबमिट करें। आवश्यकता पड़ने पर आउटवर्ड रद्द भी किया जा सकता है।
5. गुणवत्ता जांच (Quality Calculator): स्मार्ट गुणवत्ता कैलकुलेटर में FM (फॉरेन मैटर), Moisture (नमी %), Dana और Tikki के मान दर्ज करके अपने अनाज का सही मूल्य (QV Price & Final Price) जांचें।
6. गेटपास (Gatepass): जमा अनाज का गेटपास नंबर, वजन, चिठ्ठा संख्या और गुणवत्ता रिपोर्ट देखें। गेटपास से सीधे लोन आवेदन या बिक्री के लिए माल खोल सकते हैं।''';
        break;

      case AiModel.sales:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ सेल्स एवं ट्रेडिंग विशेषज्ञ (Sales & Trading Expert) हैं। आप आज के फसल बाजार भाव, SBT (Stock Based Trading), WBT (Warehouse Based Trading), Spot Deals, Face to Face (F2F) डील्स, बोली लगाने और बिक्री प्रक्रिया की पूरी जानकारी देते हैं।''';
        knowledgeBase = '''अपना गोदाम ऐप व्यापार नियम एवं रोडमैप (Sales & Trading Roadmap & Features):
1. SBT (Stock Based Trade): एडवांस बुकिंग व्यापार। फैक्ट्री आधारित या गोदाम आधारित। इसमें Upper Circuit (अधिकतम मूल्य) व Lower Circuit (न्यूनतम मूल्य) और बोली समय सीमा (जैसे 03:00 PM से 04:00 PM) होती है।
   - बोली प्रक्रिया: 'ऑर्डर जोड़ें' पर क्लिक करके खरीद या बिक्री भाव व मात्रा क्विंटल में दर्ज करें। क्रेता व विक्रेता के भाव मैच होते ही सौदा (Order ID) जनरेट हो जाता है।
   - सौदा पूरा करना (Dispatch & GRN): सौदा मैच होने पर सेलर 'अनाज भेजें' पर क्लिक कर पिनकोड, Mandi Compliance, कांटा पर्ची फोटो, बिल्टी फोटो, ट्रक/ड्राइवर फोटो अपलोड कर GRN सबमिट करता है। GRN अप्रूव होते ही सौदा पूरा होता है।
2. WBT (Warehouse Based Trade): certified गोदामों में जमा अनाज का व्यापार। 'चिठ्ठा अनुसार' या 'गेटपास अनुसार'। क्रेता अपनी बोली लगाता है, भाव मैच होने पर सौदा फाइनल होता है।
3. Spot Deals: स्पॉट में अनाज चुनने के बाद सीधे 'खरीदना' या 'बेचना' चुनकर गोदाम/स्थान, भाव और शिपमेंट कोड दर्ज करके सौदा पूरा करें।
4. Face to Face (F2F) डील्स: क्रेता और विक्रेता का सीधा सौदा। सेलर ऐप में मूल्य व वजन दर्ज कर QR कोड जनरेट करता है; बायर QR स्कैन करके फोटो अपलोड करता है और सौदा तुरंत पूरा हो जाता है।
5. डिलीवरी चिन्हित करें (Delivery Marking): गोदाम पर सौदा होने के बाद डिलीवरी मार्क करके कन्फर्म्ड ऑर्डर सेटलमेंट रिपोर्ट देखें व डाउनलोड करें।''';
        break;

      case AiModel.accounts:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ अकाउंट्स एवं फाइनेंस विशेषज्ञ (Accounts & Finance Expert) हैं। आप ऐप के वॉलेट (भंडारण खाता, व्यापार खाता, ऋण खाता), पैसे जोड़ने/निकालने, BNPL कॉमोडिटी लोन, पुनर्भुगतान (Repayment), बिल (Invoices) और परिवहन (Transport) की पूरी जानकारी देते हैं।''';
        knowledgeBase = '''अपना गोदाम ऐप अकाउंट्स एवं फाइनेंस नियम (Accounts & Finance Roadmap & Features):
1. 3 प्रकार के वॉलेट (Wallet Types):
   - भंडारण खाता (Storage Wallet): गोदाम किराया व रखवाई के लिए वॉलेट। 'पैसे निकालें' बटन से सीधे बैंक खाते में ट्रांसफर करें और 'पैसे जोड़ें' से बैंक खाता/UPI ID (HDFC/Singodwala) देखें।
   - व्यापार खाता (Trade Wallet): SBT/WBT ट्रेडिंग, अमानत राशि और सौदे के लेन-देन के लिए अलग वॉलेट।
   - ऋण खाता (Loan Wallet): गोदाम में रखे माल पर स्वीकृत लोन का हिसाब।
2. पैसे निकालना व जमा (Withdraw / Add Money): वॉलेट से अपनी प्रभावी राशि दर्ज करके तुरंत सुरक्षित बैंक ट्रांसफर प्राप्त करें। पीडीएफ विवरण भी निकाल सकते हैं।
3. BNPL कॉमोडिटी लोन (Buy Now Pay Later): गोदाम में जमा अनाज के आधार पर बिना बेचे तुरंत लोन (अधिकतम सीमा ₹1,50,00,000 तक) प्राप्त करें। 'बीएनपीएल के लिए आवेदन करें' पर क्लिक कर वांछित राशि दर्ज करें।
4. पुनर्भुगतान (Repayment): बकाया राशि, ब्याज और गोदाम किराया देखकर गोदाम/अनाज/चिठ्ठा चुनकर बकाया ऋण का भुगतान करें। समस्या पर IVR से संपर्क करें।
5. बिल (Invoices): 'मेरे द्वारा उठाए गए बिल' और 'मुझसे उठाए गए बिल' में सौदा पर्ची, टैक्स इनवॉइस और विवरण देखें व डाउनलोड करें।
6. परिवहन (Transport / Trip): 'परिवहन पिक-अप' और 'ड्रॉप' सुविधा से पिक-अप/डिलीवरी स्थान (गोदाम या अन्य), अनाज, पाने वाले का नाम/नंबर, ऑटो बिलिंग, गाड़ी भाड़ा व अग्रिम राशि चुनकर ट्रिप/परिवहन आईडी बनाएं।''';
        break;
    }

    return '''$langInstruction

$roleDescription

$knowledgeBase

संदर्भ (Context): $intentContext

क्रॉप नाम मैपिंग (Crop Synonyms):
- 'jo' / 'jau' / 'जौ' = Barley / जौ
- 'gehu' / 'गेहूं' / 'wheat' = Wheat / गेहूं
- 'chana' / 'चना' = Gram / चना
- 'sarson' / 'सरसों' = Mustard / सरसों
- 'mungfali' / 'मूंगफली' = Groundnut / मूंगफली
- 'makka' / 'मक्का' = Maize / मक्का

लाइव बाजार डेटा (Live Market Data):
$marketData

नियम (Rules):
1. यदि प्रश्न किसी फसल के लाइव रेट का है और डेटा में उपलब्ध है, तो सटीक रेट हिंदी में बताएं।
2. यदि फसल का रेट आज के लाइव डेटा में नहीं है, तो स्पष्ट हिंदी में कहें कि "आज के लाइव डेटा में [फसल] का भाव उपलब्ध नहीं है। कृपया ऐप के व्यापार सेक्शन में बोलियां देखें।"
3. यदि प्रश्न ऐप की किसी प्रक्रिया (जैसे इनवर्ड, आउटवर्ड, चिठ्ठा बुकिंग, SBT/WBT व्यापार, F2F स्कैनिंग, वॉलेट निकासी, BNPL लोन, बिल या परिवहन) से संबंधित है, तो ऊपर दी गई पूरी ट्रेनिंग के आधार पर सटीक और सरल हिंदी (देवनागरी) में 2-3 वाक्यों में उत्तर दें।''';
  }
}
