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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'][0]['text'] as String;
      } else {
        final err = jsonDecode(response.body);
        throw Exception('Claude API error: ${err['error']['message']}');
      }
    } catch (e) {
      if (isHindi) {
        return 'माफ करें, अभी जवाब देने में समस्या हो रही है। कृपया दोबारा कोशिश करें।';
      } else {
        return 'Sorry, there was an issue getting a response. Please try again.';
      }
    }
  }

  static String _buildSystemPrompt({
    required AiModel model,
    required String intent,
    required String marketData,
    required bool isHindi,
  }) {
    final langInstruction = isHindi
        ? 'IMPORTANT: Always respond in simple Hindi (Devanagari script). Use easy words that a farmer can understand. Keep responses short and clear.'
        : 'IMPORTANT: Always respond in simple English. Keep responses short and clear for farmers.';

    final intentContext = intent == 'buy'
        ? (isHindi ? 'किसान खरीदना चाहता है' : 'The farmer wants to BUY')
        : (isHindi ? 'किसान बेचना चाहता है' : 'The farmer wants to SELL');

    String roleDescription;
    switch (model) {
      case AiModel.operations:
        roleDescription = isHindi
            ? '''आप अपना गोदाम के ऑपरेशन विशेषज्ञ हैं। आप गोदाम में माल रखने, निकालने, स्टॉक की जानकारी, इनवर्ड/आउटवर्ड प्रक्रिया के बारे में बताते हैं।
विशेषज्ञता: गोदाम सुविधा, स्टॉक मैनेजमेंट, माल रखवाई-निकलवाई।'''
            : '''You are an Operations Expert for Apna Godam. You help farmers with warehouse storage, stock management, inward/outward processes, and godown facilities.
Expertise: Warehouse facilities, stock management, inward/outward requests.''';
        break;
      case AiModel.sales:
        roleDescription = isHindi
            ? '''आप अपना गोदाम के सेल्स विशेषज्ञ हैं। आप आज के बाजार भाव, खरीद-बिक्री दरें, और व्यापार के बारे में बताते हैं।
विशेषज्ञता: बाजार भाव, SBT/WBT ट्रेडिंग, बोली लगाना, खरीद-बिक्री।'''
            : '''You are a Sales Expert for Apna Godam. You help farmers with today's market rates, buy/sell prices, bidding, and trading.
Expertise: Market rates, SBT/WBT trading, bidding, buy/sell transactions.''';
        break;
      case AiModel.accounts:
        roleDescription = isHindi
            ? '''आप अपना गोदाम के अकाउंट्स विशेषज्ञ हैं। आप वॉलेट बैलेंस, भुगतान, सेटलमेंट, और पैसों से जुड़े मामलों में मदद करते हैं।
विशेषज्ञता: वॉलेट, भुगतान, सेटलमेंट, BNPL, कर्ज चुकाना।'''
            : '''You are an Accounts Expert for Apna Godam. You help farmers with wallet balance, payments, settlements, and financial matters.
Expertise: Wallet, payments, settlements, BNPL, repayments.''';
        break;
    }

    return '''$langInstruction

$roleDescription

CONTEXT: $intentContext

LIVE MARKET DATA (use this to answer rate questions):
$marketData

RULES:
- Answer ONLY what the farmer asked. Be brief (2-3 sentences max).
- If rates are mentioned in the market data, quote them exactly.
- If you don't have the exact information, say so honestly and suggest they check the app.
- Do NOT make up prices or data.
- Use simple words suitable for a farmer (not a tech person).
- If farmer asks about a commodity not in the data, say it's not available today.''';
  }
}
