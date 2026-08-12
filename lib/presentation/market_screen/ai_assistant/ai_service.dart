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

  /// Smart local answer generator covering ALL 200 Questions, Roles, Actions, Charges, Objects, and IVR Fallback across all languages.
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

    // ── 1. WEIGH SLIP / KATA PARCHI (कांटा पर्ची) ──
    if (q.contains('कांटा पर्ची') || q.contains('कट पर्ची') || q.contains('kata parchi') || q.contains('kanta parchi') || q.contains('weigh slip') || q.contains('तोल पर्ची')) {
      if (isEnglishQuery) {
        return 'Kata Parchi (Weigh Slip) records the official weighment transaction including gross weight, tare weight, net weight, vehicle number, date/time, and material details.';
      }
      if (isGujarati) {
        return 'કાંટા પર્ચી (Weigh Slip) અનાજના તોલની સત્તાવાર રસીદ છે, જેમાં વાહન નંબર, ગ્રોસ વજન, ટેર વજન અને નેટ વજન નોંધાય છે.';
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
      if (isGujarati) {
        return 'ભેજ માપક (Moisture Meter)થી અનાજનો ભેજ મપાય છે. ત્રિપાલ વરસાદથી બોરીઓને રક્ષણ આપે છે અને પાખીથી અનાજ સાફ થાય છે.';
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
      if (isGujarati) {
        return 'કાંટા મેન (Weighbridge Operator) ધર્મ કાંટા પર ગાડીઓ અને અનાજનું સાચું વજન કરીને રસીદ આપે છે.';
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
      if (isGujarati) {
        return 'ક્વોલિટી અસેયર (Quality Assayer) અનાજનો સેમ્પલ લઈને ભેજ %, કચરો અને ગુણવત્તા ચકાસીને રિપોર્ટ બનાવે છે.';
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
      if (isGujarati) {
        return 'ગોડાઉન સુપરવાઇઝર સમગ્ર વ્યવસ્થા જુએ છે. મજૂર (Labour) લોડિંગ, અનલોડિંગ, સિલાઇ અને સફાઇ કરે છે.';
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
      if (isGujarati) {
        return 'અપના ગોડાઉનમાં લોડિંગ/અનલોડિંગ ચાર્જ, ટ્રાન્સપોર્ટ ભાડું, મંડી ટેક્સ અને કાંટા પર્ચી ચાર્જ નિયમ મુજબ પારદર્શક રીતે લાગુ થાય છે.';
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
      if (isGujarati) {
        return 'સિકાઈ મગફળી પશ્ચિમ રાજસ્થાનની સોનેરી ફોતરાંવાળી આખી શેકેલી મગફળી છે. તેમાં માત્ર "ખલા" મગફળી વપરાય છે.';
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
      if (isGujarati) {
        return 'છોડ સાથે મૂળમાંથી નીકળતી મગફળીને "ખલા" કહે છે. જમીનમાં રહી જતી મગફળીને "ચુગ્ગા" કહે છે, જે તેલ ક્વોલિટીમાં ગણાય છે.';
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
      if (isGujarati) {
        return 'મગફળીની સામાન્ય ટ્રક ક્ષમતા 20 થી 25 ટન હોય છે. જો તમારી પાસે 25 ટન માલ હોય તો તરત ટ્રેડિંગ સભ્ય મોકલવામાં આવે છે.';
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
      if (isGujarati) {
        return 'મગફળીનો સોદો માત્ર જમીન અથવા માલના અસલી માલિક (Owner) સાથે જ થાય છે. બટાઈદાર અથવા મજૂરે માલિકનો નંબર આપવો પડશે.';
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
      if (isGujarati) {
        return 'ગોડાઉનમાં માલ જમા (Inward) કરવા માટે:\n1. એપ્લિકેશનમાં "માલ જમા" પર ક્લિક કરો.\n2. તમારું ગોડાઉન, અનાજ અને સ્ટેક નંબર પસંદ કરો.\n3. વજન અને વાહન નંબર ભરીને સબમિટ કરો.';
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
      if (isGujarati) {
        return 'ગોડાઉનમાંથી માલ કાઢવા (Outward) માટે:\n1. "માલ નિકાસી" પર ક્લિક કરો.\n2. તમારું સ્ટેક પસંદ કરો અને વજન ભરી સબમિટ કરો.';
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
      if (isGujarati) {
        return 'ડિજિટલ ગેટ પાસ (Gate Pass) માટે ઈનવર્ડ કે આઉટવર્ડ વિનંતી મંજૂર થતાં જ એપ્લિકેશનમાં QR ગેટ પાસ જનરેટ થઈ જાય છે.';
      }
      if (isBhojpuri) {
        return 'डिजिटल गेट पास (Gate Pass) बनावे खातिर इनवर्ड भा आउटवर्ड रिक्वेस्ट सबमिट करीं, अप्रूवल मिलत ही ऐप में QR कोड गेट पास जारी हो जाई।';
      }
      if (isHindi) {
        return 'डिजिटल गेट पास (Gate Pass) बनाने के लिए इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करें, अप्रूवल मिलते ही ऐप में QR कोड गेट पास जारी हो जाएगा।';
      }
      return 'डिजिटल गेट पास (Gate Pass) बणावण वास्ते इनवर्ड या आउटवर्ड रिक्वेस्ट सबमिट करो सा, अप्रूवल मिलता ही QR कोड गेट पास ऐप में बण ज्यासी सा।';
    }

    // ── 6.5. LOANS, PLEDGE FINANCE & BNPL ──
    if (q.contains('लोन') || q.contains('loan') || q.contains('गिरवी') || q.contains('pledge') || q.contains('bnpl')) {
      if (isEnglishQuery) {
        return 'Apna Godam offers instant collateral bank loans up to 75% of your stored crop value at 8-11% p.a. interest, plus BNPL credit limits for trading.';
      }
      if (isGujarati) {
        return 'અપના ગોડાઉનમાં જમા માલ પર 75% સુધી તુરંત બેંક લોન (Pledge Loan) અને ટ્રેડિંગ માટે BNPL લિમિટ મળે છે.';
      }
      if (isBhojpuri) {
        return 'अपना गोदाम में जमा फसल के रसीद पर 75% तक बैंक लोन अउर व्यापार खातिर BNPL सुविधा मिलेला।';
      }
      if (isHindi) {
        return 'अपना गोदाम में जमा फसल पर 75% तक तुरंत बैंक लोन (Pledge Loan) और व्यापार के लिए BNPL क्रेडिट सुविधा मिलती है।';
      }
      return 'सा, अपना गोदाम मांय जमा माल पर 75% तक तुरंत बैंक लोन अर व्यापार वास्ते BNPL सुविधा मिलै छै सा।';
    }

    if (q.contains('सौदा') || q.contains('बोली') || q.contains('bid') || q.contains('wbt') || q.contains('sbt') || q.contains('व्यापार') || q.contains('trade')) {
      if (isEnglishQuery) {
        return 'Apna Godam supports WBT (Warehouse Based Trading) & SBT (Stock Based Trading) with live buy/sell bidding and 24-hour instant seller payments.';
      }
      if (isGujarati) {
        return 'અપના ગોડાઉનમાં WBT અને SBT દ્વારા લાઈવ બોલી લગાવીને અનાજનો વેપાર થાય છે અને 24 કલાકમાં ચૂકવણી મળે છે.';
      }
      if (isBhojpuri) {
        return 'अपना गोदाम में WBT अउर SBT द्वारा फसल के लाइव बोली लगा के खरीद-बिक्री कइल जाला अउर 24 घंटा में भुगतान मिलेला।';
      }
      if (isHindi) {
        return 'अपना गोदाम पर WBT और SBT द्वारा लाइव बोलियां लगाकर फसल खरीद-बिक्री की जाती है और 24 घंटे में सीधे बैंक खाते में भुगतान मिलता है।';
      }
      return 'सा, अपना गोदाम पर WBT अर SBT सूं लाइव बोली लगाइने व्यापार कर्यो जावै छै अर 24 घंटा में पक्को भुगतान मिलै छै सा।';
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
   - ENGLISH QUERY ("how make gatepass", "what is my name"): RESPOND 100% IN PURE ENGLISH!
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
