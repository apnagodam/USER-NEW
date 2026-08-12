import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';
import 'hugging_face_service.dart';
import 'qa_dataset_200.dart';

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

  /// Sends a farmer's question with live market data and user profile context.
  static Future<String> askClaude({
    required String question,
    required String marketData,
    List<Map<String, String>>? history,
    bool isHindi = true,
    Map<String, dynamic>? userProfile,
  }) async {
    // Format profile context for system instructions
    final profileContextStr = _buildProfileContextString(userProfile);
    final fullContextData = '$marketData\n\n$profileContextStr';

    // 1. Try Hugging Face Inference API Model for regional dialect across all Indian languages
    try {
      final hfResult = await HuggingFaceService.queryHuggingFaceModel(
        prompt: question,
        contextData: fullContextData,
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
      marketData: fullContextData,
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

    return fallbackMarketResponse(
      question,
      marketData,
      history: history,
      userProfile: userProfile,
    );
  }

  static String _buildProfileContextString(Map<String, dynamic>? userProfile) {
    if (userProfile == null || userProfile['isLoggedIn'] != true) {
      return 'USER LOGIN STATUS: Not Logged In';
    }
    return '''USER PROFILE DATA (AUTHENTICATED & LOGGED IN USER):
• Name: ${userProfile['name'] ?? 'N/A'}
• Phone Number: ${userProfile['phone'] ?? 'N/A'}
• Email Address: ${userProfile['email'] ?? 'N/A'}
• Address: ${userProfile['address'] ?? 'N/A'}
• Wallet Amount / Trade Power: ₹${userProfile['walletAmount'] ?? 0}
• Firm Name: ${userProfile['firmName'] ?? 'N/A'}
• GST Number: ${userProfile['gstNumber'] ?? 'N/A'}
• Aadhar Number: ${userProfile['aadharNo'] ?? 'N/A'}
• PAN Number: ${userProfile['panNo'] ?? 'N/A'}
• Bank Name: ${userProfile['bankName'] ?? 'N/A'}
• Bank Account No: ${userProfile['bankAccNo'] ?? 'N/A'}
• KYC Verification Status: ${userProfile['kycVerified'] == true ? 'Complete & Verified' : 'Pending'}''';
  }

  /// Smart local answer generator covering ALL 200 Questions from PDF/Matrix.
  static String fallbackMarketResponse(
    String question,
    String marketData, {
    List<Map<String, String>>? history,
    Map<String, dynamic>? userProfile,
  }) {
    final q = question.toLowerCase().trim();

    // Detect English Query: English letters, no Devanagari/Gujarati, no Roman Marwari markers
    final hasEnglishChars = RegExp(r'[a-zA-Z]').hasMatch(q);
    final hasDevanagariChars = RegExp(r'[\u0900-\u097F]').hasMatch(question);
    final hasGujaratiChars = RegExp(r'[\u0A80-\u0AFF]').hasMatch(question);
    final isRomanMarwari = q.contains('chhe') ||
        q.contains('che') ||
        q.contains('mhane') ||
        q.contains('tharo') ||
        q.contains('bechain') ||
        q.contains('bechni') ||
        q.contains('kai') ||
        q.contains('katra');

    final isEnglishQuery = hasEnglishChars && !hasDevanagariChars && !hasGujaratiChars && !isRomanMarwari;

    // Detect Dialects & Languages
    final isGujarati = hasGujaratiChars || q.contains('ભાવ') || q.contains('તમારું') || q.contains('વિગતો') || q.contains('ગુજરાતી');
    final isBhojpuri = q.contains('का बा') || q.contains('केतना') || q.contains('कइसे') || q.contains('हमरा') || q.contains('हमार') || q.contains('रउआ') || q.contains('बाते') || q.contains('बा') || q.contains('करीं') || q.contains('बनी') || q.contains('बताईं');
    final isMaithili = q.contains('अहाँ') || q.contains('की') || q.contains('कतबा') || q.contains('कोना') || q.contains('अछि');
    final isHindi = q.contains('क्या') || q.contains('कैसे') || q.contains('कितना') || q.contains('बनाएं') || q.contains('बताएं') || q.contains('बताओ');

    // ── 0. DYNAMIC USER PROFILE QUERY ENGINE (NAME, EMAIL, NUMBER, ADDRESS, WALLET, STOCK) ──
    final isLoggedIn = userProfile != null && userProfile['isLoggedIn'] == true;
    final name = (userProfile != null && userProfile['name'] != null && userProfile['name'].toString().trim().isNotEmpty)
        ? userProfile['name'].toString().trim()
        : 'N/A';
    final email = (userProfile != null && userProfile['email'] != null && userProfile['email'].toString().trim().isNotEmpty)
        ? userProfile['email'].toString().trim()
        : 'N/A';
    final phone = (userProfile != null && userProfile['phone'] != null && userProfile['phone'].toString().trim().isNotEmpty)
        ? userProfile['phone'].toString().trim()
        : 'N/A';
    final address = (userProfile != null && userProfile['address'] != null && userProfile['address'].toString().trim().isNotEmpty)
        ? userProfile['address'].toString().trim()
        : 'N/A';
    final walletAmount = userProfile?['walletAmount'] ?? 0;

    // Check specific name query
    if (q.contains('नाम') || q.contains('name') || q.contains('मेरा नाम') || q.contains('माहरो नाम') || q.contains('हमार नाम') || q.contains('નામ')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to your Apna Godam account to view your registered profile name.';
        if (isGujarati) return 'તમારું રજિસ્ટર્ડ નામ જોવા માટે કૃપા કરીને લોગિન કરો.';
        if (isBhojpuri) return 'अपना रजिस्टर्ड नाम देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना पंजीकृत नाम देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरो रजिस्टर्ड नाम देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your registered name in Apna Godam is $name.';
      if (isGujarati) return 'તમારું રજિસ્ટર્ડ નામ $name છે.';
      if (isBhojpuri) return 'अपना गोदाम में रउआ रजिस्टर्ड नाम $name बा।';
      if (isHindi) return 'अपना गोदाम में आपका पंजीकृत नाम $name है।';
      return 'सा, अपना गोदाम में आपरो रजिस्टर्ड नाम $name छै सा।';
    }

    // Check specific email query
    if (q.contains('ईमेल') || q.contains('इमेल') || q.contains('email') || q.contains('ઈમેલ')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your registered email address.';
        if (isGujarati) return 'તમારું ઈમેલ આઈડી જોવા માટે લોગિન કરો.';
        if (isBhojpuri) return 'अपना रजिस्टर्ड ईमेल देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना पंजीकृत ईमेल देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरी रजिस्टर्ड ईमेल देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your registered email address is $email.';
      if (isGujarati) return 'તમારું રજિસ્ટર્ડ ઈમેલ $email છે.';
      if (isBhojpuri) return 'रउआ रजिस्टर्ड ईमेल $email बा।';
      if (isHindi) return 'आपका पंजीकृत ईमेल $email है।';
      return 'सा, आपरी रजिस्टर्ड ईमेल $email छै सा।';
    }

    // Check specific mobile/phone number query
    if (q.contains('नंबर') || q.contains('नम्बर') || q.contains('मोबाइल') || q.contains('फोन') || q.contains('phone') || q.contains('number') || q.contains('mobile') || q.contains('નંબર')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your registered mobile number.';
        if (isGujarati) return 'તમારો મોબાઇલ નંબર જોવા માટે લોગિન કરો.';
        if (isBhojpuri) return 'अपना रजिस्टर्ड नंबर देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना पंजीकृत मोबाइल नंबर देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरो रजिस्टर्ड मोबाइल नंबर देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your registered mobile number is $phone.';
      if (isGujarati) return 'તમારો રજિસ્ટર્ડ મોબાઇલ નંબર $phone છે.';
      if (isBhojpuri) return 'रउआ रजिस्टर्ड मोबाइल नंबर $phone बा।';
      if (isHindi) return 'आपका पंजीकृत मोबाइल नंबर $phone है।';
      return 'सा, आपरो रजिस्टर्ड मोबाइल नंबर $phone छै सा।';
    }

    // Check specific address/location query
    if (q.contains('पता') || q.contains('पतो') || q.contains('एड्रेस') || q.contains('address') || q.contains('location') || q.contains('गाँव') || q.contains('जिला') || q.contains('સરનામું')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your registered address.';
        if (isGujarati) return 'તમારું સરનામું જોવા માટે લોગિન કરો.';
        if (isBhojpuri) return 'अपना दर्ज पता देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना दर्ज पता देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरो दर्ज पतो देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your registered address is: $address.';
      if (isGujarati) return 'તમારું રજિસ્ટર્ડ સરનામું: $address છે.';
      if (isBhojpuri) return 'रउआ दर्ज पता: $address बा।';
      if (isHindi) return 'आपका दर्ज पता: $address है।';
      return 'सा, आपरो दर्ज पतो: $address छै सा।';
    }

    // Check specific wallet amount / balance query
    if (q.contains('वॉलेट') || q.contains('बैलेंस') || q.contains('balance') || q.contains('wallet') || q.contains('पैसा') || q.contains('रुपया') || q.contains('क्रेडिट') || q.contains('વોલેટ')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your wallet balance.';
        if (isGujarati) return 'તમારું વોલેટ બેલેન્સ જોવા માટે લોગિન કરો.';
        if (isBhojpuri) return 'अपना वॉलेट बैलेंस देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना वॉलेट बैलेंस देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरो वॉलेट बैलेंस देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your current wallet trade balance is ₹$walletAmount.';
      if (isGujarati) return 'તમારું વોલેટ ટ્રેડ બેલેન્સ ₹$walletAmount છે.';
      if (isBhojpuri) return 'रउआ वॉलेट ट्रेड बैलेंस ₹$walletAmount बा।';
      if (isHindi) return 'आपका वॉलेट ट्रेड बैलेंस ₹$walletAmount है।';
      return 'सा, आपरो वॉलेट ट्रेड बैलेंस ₹$walletAmount छै सा।';
    }

    // Check specific stock/storage query
    if (q.contains('स्टॉक') || q.contains('stock') || q.contains('जमा माल') || q.contains('बोरियां') || q.contains('સ્ટોક')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your stored stock in Apna Godam.';
        if (isGujarati) return 'તમારો ગોડાઉન સ્ટોક જોવા માટે લોગિન કરો.';
        if (isBhojpuri) return 'अपना जमा माल अउर स्टॉक देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपना जमा स्टॉक देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'आपरो जमा स्टॉक देखण वास्ते ऐप में लॉगिन करो सा।';
      }
      if (isEnglishQuery) return 'Your stored crop stock details are available in the "My Stock" section of Apna Godam.';
      if (isGujarati) return 'તમારા ગોડાઉનમાં જમા માલની વિગતો "My Stock" વિભાગમાં ઉપલબ્ધ છે.';
      if (isBhojpuri) return 'अपना गोदाम में रउआ जमा माल अउर स्टॉक के जानकारी "माय स्टॉक" सेक्शन में उपलब्ध बा।';
      if (isHindi) return 'अपना गोदाम में आपके जमा स्टॉक की जानकारी "माय स्टॉक" सेक्शन में उपलब्ध है।';
      return 'सा, अपना गोदाम में आपरे जमा स्टॉक री जानकारी "माय स्टॉक" सेक्शन में उपलब्ध छै सा।';
    }

    // Check general profile query
    if (q.contains('पर्सनल') ||
        q.contains('प्रोफाइल') ||
        q.contains('प्रोफ़ाइल') ||
        q.contains('माहरो अकाउंट') ||
        q.contains('मेरा अकाउंट') ||
        q.contains('मेरा डिटेल') ||
        q.contains('profile') ||
        q.contains('personal') ||
        q.contains('my account')) {
      if (!isLoggedIn) {
        if (isEnglishQuery) return 'Please log in to view your authenticated personal profile.';
        if (isGujarati) return 'તમારી પ્રોફાઇલ વિગતો જોવા માટે કૃપા કરીને લોગિન કરો.';
        if (isBhojpuri) return 'अपना पर्सनल जानकारी देखे खातिर ऐप में लॉगिन करीं।';
        if (isHindi) return 'अपनी व्यक्तिगत जानकारी (प्रोफाइल/बैलेंस) देखने के लिए कृपया ऐप में लॉगिन करें।';
        return 'सा, आपरी पर्सनल जानकारी (प्रोफाइल/बैलेंस) देखण वास्ते ऐप में लॉगिन करो सा।';
      }

      if (isEnglishQuery) {
        return 'Here are your profile details:\n• Name: $name\n• Mobile: $phone\n• Email: $email\n• Address: $address\n• Wallet Balance: ₹$walletAmount';
      }
      if (isGujarati) {
        return 'તમારી પ્રોફાઇલ વિગતો:\n• નામ: $name\n• મોબાઇલ: $phone\n• ઈમેલ: $email\n• સરનામું: $address\n• વોલેટ બેલેન્સ: ₹$walletAmount';
      }
      if (isBhojpuri) {
        return 'रउआ प्रोफाइल जानकारी:\n• नाम: $name\n• मोबाइल: $phone\n• ईमेल: $email\n• पता: $address\n• वॉलेट बैलेंस: ₹$walletAmount';
      }
      if (isHindi) {
        return 'आपकी प्रोफाइल जानकारी:\n• नाम: $name\n• मोबाइल: $phone\n• ईमेल: $email\n• पता: $address\n• वॉलेट बैलेंस: ₹$walletAmount';
      }
      return 'आपरी प्रोफाइल री जानकारी:\n• नाम: $name\n• मोबाइल: $phone\n• ईमेल: $email\n• पतो: $address\n• वॉलेट बैलेंस: ₹$walletAmount';
    }

    // ── 0.5 CHECK 200 QUESTION MATRIX DATASET FIRST FOR 100% EXACT MATCH! ──
    for (final item in QaDataset200.items) {
      for (final kw in item.keywords) {
        if (q.contains(kw.toLowerCase())) {
          if (isEnglishQuery) return item.en;
          if (isGujarati) return item.guj;
          if (isBhojpuri) return item.bho;
          if (isHindi) return item.hi;
          return item.mwr;
        }
      }
    }

    // ── 7. LIVE CROP RATES INQUIRY (STRICT BACKEND API DATA ONLY - NO HARDCODED NUMBERS) ──
    String searchedCropName = '';
    String cropDisplayName = '';
    String cropDisplayNameEn = '';
    List<String> keywords = [];

    if (q.contains('गेहूं') || q.contains('gehu') || q.contains('wheat') || q.contains('ઘઉં')) {
      searchedCropName = 'गेहूं'; cropDisplayName = 'गेहूं'; cropDisplayNameEn = 'Wheat'; keywords = ['गेहूं', 'wheat', 'gehu', 'ઘઉં'];
    } else if (q.contains('जौ') || q.contains('jau') || q.contains('barley') || q.contains('જવ')) {
      searchedCropName = 'जौ'; cropDisplayName = 'जौ'; cropDisplayNameEn = 'Barley'; keywords = ['जौ', 'barley', 'barley 2026', 'jau', 'jo', 'જવ'];
    } else if (q.contains('चना') || q.contains('chana') || q.contains('gram') || q.contains('ચણા')) {
      searchedCropName = 'चना'; cropDisplayName = 'चना'; cropDisplayNameEn = 'Gram'; keywords = ['चना', 'gram', 'chana', 'ચણા'];
    } else if (q.contains('सरसों') || q.contains('mustard') || q.contains('रोजा') || q.contains('रोजी') || q.contains('રાયડો')) {
      searchedCropName = 'सरसों'; cropDisplayName = 'सरसों'; cropDisplayNameEn = 'Mustard'; keywords = ['सरसों', 'mustard', 'sarso', 'सरसो', 'રાયડો'];
    } else if (q.contains('मूंगफली') || q.contains('mungfali') || q.contains('groundnut') || q.contains('ground nut') || q.contains('सिंगदाना') || q.contains('गोटा') || q.contains('મગફળી')) {
      searchedCropName = 'मूंगफली'; cropDisplayName = 'मूंगफली'; cropDisplayNameEn = 'Groundnut'; keywords = ['मूंगफली', 'ground nut', 'groundnut', 'mungfali', 'सिकाई', 'सिंगदाना', 'गोटा', 'oil quality', 'મગફળી'];
    } else if (q.contains('मक्का') || q.contains('maize') || q.contains('મકાઈ')) {
      searchedCropName = 'मक्का'; cropDisplayName = 'मक्का'; cropDisplayNameEn = 'Maize'; keywords = ['मक्का', 'maize', 'makka', 'મકાઈ'];
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
        if (isGujarati) {
          return 'હાલમાં $cropDisplayNameEn ના લાઈવ મંડી ભાવ ઉપલબ્ધ નથી. તાજા ભાવ માટે અમારી IVR હેલ્પલાઈન 7733901154 પર કોલ કરો.';
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
      if (isGujarati) {
        return 'આજે $cropDisplayNameEn નો લાઈવ ભાવ ₹$priceDisplay/ક્વિન્ટલ છે. તમે ખરીદવા કે વેચવા માંગો છો?';
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
    if (isGujarati) {
      return 'માફ કરશો, આ પ્રશ્નની માહિતી મારી પાસે નથી. વધુ માહિતી માટે અમારી IVR હેલ્પલાઇન 7733901154 પર કોલ કરો.';
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
   - ENGLISH QUERY ("how make gatepass", "what is pocket scale"): RESPOND 100% IN PURE ENGLISH!
   - GUJARATI QUERY ("આજે ઘઉંનો ભાવ કેટલો છે"): RESPOND 100% IN PURE NATIVE GUJARATI!
   - BHOJPURI QUERY ("हमार नाम का बा"): RESPOND 100% IN PURE BHOJPURI!
   - HINDI QUERY ("मेरा नाम क्या है"): RESPOND 100% IN PURE SIMPLE HINDI!
   - MARWARI QUERY ("माहरो नाम कांई छै"): RESPOND 100% IN PURE RESPECTFUL MARWARI!

2. USER PROFILE QUERIES:
   If the user is logged in, answer questions about their name, email, mobile number, address, wallet amount, or stock using the provided USER PROFILE DATA.

LIVE MARKET & PROFILE DATA:
$marketData''';
  }
}
