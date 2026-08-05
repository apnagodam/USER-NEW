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

  /// Local fallback when API has network/credit issues:
  /// Scans live marketData lines for crop name and returns exact rates in Hindi.
  static String _fallbackMarketResponse(String question, String marketData) {
    final q = question.toLowerCase();
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

      // If specific crop was asked but not found in today's API list
      if (searchedCropName.isNotEmpty) {
        return 'आज के लाइव बाजार डेटा में $searchedCropName का भाव/बोली उपलब्ध नहीं है। कृपया ऐप का व्यापार (SBT/WBT) सेक्शन देखें।';
      }

      // If no specific crop was mentioned, return top live market rates
      final topRates = lines.where((l) => l.contains('₹') || l.contains('फसल:')).take(3).join('\n');
      if (topRates.isNotEmpty) {
        return 'आज के मुख्य लाइव बाजार भाव:\n$topRates';
      }
    }

    return 'आज के बाजार डेटा में आपकी फसल का भाव उपलब्ध नहीं है। कृपया ऐप में SBT/WBT बोलियां देखें।';
  }

  static String _buildSystemPrompt({
    required AiModel model,
    required String intent,
    required String marketData,
    required bool isHindi,
  }) {
    const langInstruction = '''CRITICAL LANGUAGE RULE:
- You MUST ALWAYS respond in simple HINDI using DEVANAGARI script (देवनागरी हिंदी).
- Even if the user speaks or types in Roman Hindi / Hinglish (for example: "aaj jo ka bhav ky h", "gehu ka rate kya hai", "aaj kitna rate h"), you MUST reply ONLY in Hindi Devanagari script (e.g. "आज जौ का भाव ₹2511 प्रति क्विंटल है।").
- Never reply in English unless the user explicitly asks a pure English question like "Speak in English".
- Keep your answer short, clear, direct, and polite (2-3 sentences max) so a farmer can easily understand and listen.''';

    final intentContext = intent == 'buy'
        ? 'किसान खरीदना चाहता है (Buyer Query)'
        : (intent == 'sell'
            ? 'किसान बेचना चाहता है (Seller Query)'
            : 'सामान्य पूछताछ (General Query)');

    String roleDescription;
    String knowledgeBase;

    switch (model) {
      case AiModel.operations:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ ऑपरेशन विशेषज्ञ (Operations Expert) हैं। आप गोदाम में माल रखने (Inward), स्टॉक निकालने (Outward), स्टैक स्थिति, गेट पास और गोदाम सुविधाओं में मदद करते हैं।''';
        knowledgeBase = '''ऑपरेशन ट्रेनिंग और नियम (Operations Knowledge Base):
1. इनवर्ड रिक्वेस्ट (Inward Request): किसान/व्यापारी ऐप में गोदाम टर्मिनल चुनकर, फसल का नाम, अनुमानित वजन और ट्रक नंबर दर्ज करके इनवर्ड रिक्वेस्ट बना सकते हैं। गोदाम पहुंचने पर नमी (Moisture) और गुणवत्ता की जांच की जाती है।
2. आउटवर्ड रिक्वेस्ट (Outward Request): गोदाम में रखे माल को बाहर निकालने के लिए ऐप के "My Stock" या इनवर्ड सेक्शन से आउटवर्ड रिक्वेस्ट जनरेट की जाती है।
3. गेट पास (Gate Pass): इनवर्ड या आउटवर्ड अप्रूवल के बाद ऐप में डिजिटल QR गेट पास बनता है जिससे गोदाम गेट पर तुरंत एंट्री/एग्जिट मिलती है।
4. स्टैक (Stack): गोदाम में हर माल का यूनिक स्टैक नंबर (जैसे Stack No. 7.1) होता है जिससे माल पूरी तरह सुरक्षित रहता है।''';
        break;

      case AiModel.sales:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ सेल्स विशेषज्ञ (Sales & Trading Expert) हैं। आप फसल के लाइव बाजार भाव, SBT (Stock Based Trading), WBT (Warehouse Based Trading), स्पोर्ट डील्स, सर्किट लिमिट और बोली लगाने की प्रक्रिया बताते हैं।''';
        knowledgeBase = '''सेल्स एवं ट्रेडिंग ट्रेनिंग (Sales & Bidding Knowledge Base):
1. SBT (Stock Based Trading): रजिस्टर्ड गोदामों में जमा माल की लाइव ऑनलाइन बोली। इसमें Upper Circuit (अधिकतम मूल्य), Lower Circuit (न्यूनतम मूल्य), LTP (अंतिम सौदा मूल्य) और निश्चित समय (जैसे 03:00 PM से 04:00 PM) होता है।
2. WBT (Warehouse Based Trading): गोदाम में रखे माल का सीधे बेस्ट बायर और सेलर रेट पर स्पॉट व्यापार।
3. बोली लगाने का नियम: बोली हमेशा लोअर और अपर सर्किट के बीच लगानी होती है। विक्रेता (Seller) को उच्चतम बोली और क्रेता (Buyer) को न्यूनतम बोली पर प्राथमिकता मिलती है।
4. F2F (Face to Face Deal): क्रेता और विक्रेता के बीच सीधी बातचीत से तय होने वाले सौदे।''';
        break;

      case AiModel.accounts:
        roleDescription = '''आप "अपना गोदाम" के वरिष्ठ अकाउंट्स विशेषज्ञ (Accounts & Finance Expert) हैं। आप वॉलेट बैलेंस, पैसे जोड़ने/निकालने (Add/Withdraw Money), सेटलमेंट, BNPL कॉमोडिटी लोन और बैंक ट्रांसफर में मदद करते हैं।''';
        knowledgeBase = '''अकाउंट्स एवं फाइनेंस ट्रेनिंग (Accounts & Finance Knowledge Base):
1. वॉलेट पावर (Wallet Power): उपलब्ध राशि जिसका उपयोग ट्रेडिंग या बैंक खाते में ट्रांसफर के लिए किया जा सकता है।
2. पैसे जोड़ना और निकालना (Add / Withdraw Money): वॉलेट सेक्शन से UPI/नेटबैंकिंग द्वारा पैसे जोड़े जा सकते हैं तथा 'Withdraw' बटन से सीधे बैंक खाते में ट्रांसफर किए जा सकते हैं।
3. BNPL लोन (Buy Now Pay Later / कॉमोडिटी लोन): गोदाम में जमा फसल के मूल्य के आधार पर स्वीकृत लोन लिमिट (Sanctioned Limit), जिससे किसान बिना फसल बेचे तुरंत पैसे प्राप्त कर सकते हैं।
4. सेटलमेंट (Settlements): सौदा पूरा होने और गेटपास जारी होने पर सेटलमेंट का पैसा तुरंत वॉलेट में क्रेडिट हो जाता है।
5. KYC एवं बैंक सत्यापन: बैंक खाता, पैन कार्ड और आधार कार्ड सत्यापित होना अनिवार्य है।''';
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
1. यदि प्रश्न लाइव रेट का है और डेटा में रेट उपलब्ध है, तो सटीक रेट हिंदी में बताएं।
2. यदि फसल का रेट आज के लाइव डेटा में नहीं है, तो विनम्रता से हिंदी में कहें कि "आज के लाइव डेटा में इस फसल का भाव उपलब्ध नहीं है, कृपया ऐप में SBT/WBT सेक्शन देखें।"
3. यदि प्रश्न इनवर्ड, आउटवर्ड, वॉलेट या लोन का है, तो ऊपर दी गई ट्रेनिंग के आधार पर सटीक और सरल हिंदी (देवनागरी) में जवाब दें।
4. उत्तर हमेशा 2-3 पंक्तियों में संक्षेप और स्पष्ट दें।''' ;
  }
}
