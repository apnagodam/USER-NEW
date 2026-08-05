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
  static const String _model = 'claude-3-5-haiku-20241022';

  /// Sends a farmer's question to Claude with live market data as context.
  /// [question] - farmer's spoken question (already transcribed)
  /// [model] - which AI persona to use
  /// [intent] - 'buy' or 'sell'
  /// [marketData] - live data fetched from backend
  /// [isHindi] - true if app language is Hindi
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

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'x-api-key': AppConfig.claudeApiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'max_tokens': 512,
          'system': systemPrompt,
          'messages': [
            {'role': 'user', 'content': question},
          ],
        }),
      );

      print('Claude API status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'][0]['text'] as String;
      } else {
        print('Claude API error body: ${response.body}');
        return _fallbackMarketResponse(question, marketData);
      }
    } catch (e) {
      print('Claude API exception: $e');
      return _fallbackMarketResponse(question, marketData);
    }
  }

  /// Local fallback when API has network/credit issues:
  /// Scans marketData lines for crop name and returns live rate in Hindi.
  static String _fallbackMarketResponse(String question, String marketData) {
    final q = question.toLowerCase();
    String targetCrop = '';
    if (q.contains('गेहूं') || q.contains('gehu') || q.contains('wheat')) {
      targetCrop = 'Wheat';
    } else if (q.contains('जौ') || q.contains('jo') || q.contains('jau') || q.contains('barley')) {
      targetCrop = 'Barley';
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram')) {
      targetCrop = 'Gram';
    } else if (q.contains('सरसों') || q.contains('sarson') || q.contains('mustard')) {
      targetCrop = 'Mustard';
    } else if (q.contains('मक्का') || q.contains('makka') || q.contains('maize')) {
      targetCrop = 'Maize';
    }

    if (marketData.isNotEmpty) {
      final lines = marketData.split('\n');
      for (final line in lines) {
        if (targetCrop.isNotEmpty && line.toLowerCase().contains(targetCrop.toLowerCase())) {
          return 'आज $targetCrop का भाव: $line। अधिक जानकारी के लिए ऐप का व्यापार सेक्शन देखें।';
        }
      }
      // If any market data lines exist, return the first 2 lines
      final previewLines = lines.where((l) => l.contains('₹')).take(2).join('\n');
      if (previewLines.isNotEmpty) {
        return 'आज के मुख्य बाजार भाव:\n$previewLines';
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
- Even if the user speaks or types in Roman Hindi / Hinglish (for example: "aaj jo ka bhav ky h", "gehu ka rate kya hai", "aaj kitna rate h"), you MUST reply ONLY in Hindi Devanagari script (e.g. "आज जौ का भाव ₹2159 प्रति क्विंटल है।").
- Never reply in English unless the user explicitly asks a pure English question like "Speak in English".
- Keep your answer short, clear, and polite (2-3 sentences max) so that a farmer can easily listen to it.''';

    final intentContext = intent == 'buy'
        ? 'किसान खरीदना चाहता है (Buyer query)'
        : (intent == 'sell'
            ? 'किसान बेचना चाहता है (Seller query)'
            : 'सामान्य पूछताछ (General query)');

    String roleDescription;
    switch (model) {
      case AiModel.operations:
        roleDescription = '''आप अपना गोदाम के "ऑपरेशन विशेषज्ञ" हैं। आप गोदाम में माल रखने, निकालने, स्टॉक की स्थिति और इनवर्ड/आउटवर्ड प्रक्रिया के बारे में बताते हैं।''';
        break;
      case AiModel.sales:
        roleDescription = '''आप अपना गोदाम के "सेल्स विशेषज्ञ" हैं। आप आज के फसल बाजार भाव, खरीद-बिक्री दरें, SBT/WBT बोलियां और मंडी भाव बताते हैं।''';
        break;
      case AiModel.accounts:
        roleDescription = '''आप अपना गोदाम के "अकाउंट्स विशेषज्ञ" हैं। आप वॉलेट बैलेंस, भुगतान, सेटलमेंट और पैसों से जुड़ी जानकारी बताते हैं।''';
        break;
    }

    return '''$langInstruction

$roleDescription

संदर्भ (Context): $intentContext

क्रॉप नाम मैपिंग (Crop Synonyms):
- 'jo' / 'jau' / 'जौ' = Barley / जौ
- 'gehu' / 'गेहूं' / 'wheat' = Wheat / गेहूं
- 'chana' / 'चना' = Gram / चना
- 'sarson' / 'सरसों' = Mustard / सरसों
- 'makka' / 'मक्का' = Maize / मक्का
- 'taramira' / 'तारामीरा' = Taramira

लाइव बाजार डेटा (Live Market Data):
$marketData

नियम (Rules):
1. अगर किसान ने किसी फसल (जैसे जौ/गेहूं) का भाव पूछा है और उसका रेट डेटा में है, तो सटीक रेट हिंदी में बताएं।
2. अगर उस फसल का रेट डेटा में नहीं दिख रहा है, तो विनम्रता से हिंदी में बताएं कि "आज डेटा में इस फसल का भाव उपलब्ध नहीं है, कृपया ऐप में SBT/WBT सेक्शन देखें।"
3. हमेशा सरल हिंदी (देवनागरी) में ही जवाब दें। 2-3 पंक्तियों से बड़ा जवाब न दें।''';
  }
}
