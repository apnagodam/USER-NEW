import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:apnagodam/core/config/app_config.dart';

/// Represents the result of an Exotel call operation
class ExotelCallResponse {
  final bool success;
  final String? callSid;
  final String? status;
  final String message;
  final String? recordingUrl;
  final String? duration;
  final Map<String, dynamic>? rawResponse;

  ExotelCallResponse({
    required this.success,
    this.callSid,
    this.status,
    required this.message,
    this.recordingUrl,
    this.duration,
    this.rawResponse,
  });

  factory ExotelCallResponse.fromJson(Map<String, dynamic> json) {
    // Exotel returns { "Call": { "Sid": "...", "Status": "...", ... } }
    final callObj = json['Call'] is Map<String, dynamic>
        ? json['Call'] as Map<String, dynamic>
        : json;

    return ExotelCallResponse(
      success: true,
      callSid: callObj['Sid']?.toString() ?? callObj['sid']?.toString(),
      status: callObj['Status']?.toString() ?? callObj['status']?.toString() ?? 'queued',
      message: 'Call initiated successfully',
      recordingUrl: callObj['RecordingUrl']?.toString(),
      duration: callObj['Duration']?.toString(),
      rawResponse: json,
    );
  }

  factory ExotelCallResponse.error(String message, [Map<String, dynamic>? raw]) {
    return ExotelCallResponse(
      success: false,
      message: message,
      rawResponse: raw,
    );
  }
}

/// Service to handle Exotel Voice API and Automated AI Calling
class ExotelService {
  /// Checks if Exotel credentials have been configured
  static bool get isConfigured {
    return AppConfig.exotelApiKey.isNotEmpty &&
        AppConfig.exotelApiKey != 'YOUR_EXOTEL_API_KEY' &&
        AppConfig.exotelApiToken.isNotEmpty &&
        AppConfig.exotelApiToken != 'YOUR_EXOTEL_API_TOKEN' &&
        AppConfig.exotelAccountSid.isNotEmpty &&
        AppConfig.exotelAccountSid != 'YOUR_EXOTEL_ACCOUNT_SID';
  }

  /// Formats an Indian mobile number to the required format (e.g. 09876543210 or +919876543210)
  static String formatIndianPhoneNumber(String rawNumber) {
    var cleaned = rawNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.startsWith('91') && cleaned.length == 12) {
      cleaned = cleaned.substring(2);
    } else if (cleaned.startsWith('0') && cleaned.length == 11) {
      cleaned = cleaned.substring(1);
    }

    if (cleaned.length == 10) {
      // Exotel standard format for Indian domestic mobile: 0 + 10 digits
      return '0$cleaned';
    }
    return rawNumber;
  }

  /// Validates if a phone number is a valid 10-digit Indian mobile number
  static bool isValidIndianPhoneNumber(String rawNumber) {
    final cleaned = rawNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length == 10) return true;
    if (cleaned.length == 11 && cleaned.startsWith('0')) return true;
    if (cleaned.length == 12 && cleaned.startsWith('91')) return true;
    return false;
  }

  /// Initiates an Automated AI Voice Call to the User's Phone via Exotel API
  /// 
  /// - [userPhone]: The user's mobile number
  /// - [topic]: Query topic (e.g., 'mandi_rates', 'warehouse_booking', 'trade_order')
  /// - [language]: Preferred dialect/language (e.g., 'hi' for Hindi, 'mwr' for Marwari, 'en' for English)
  /// - [customQuery]: Initial question or context string for the AI voice bot
  /// - [userProfile]: Optional user context map (name, mandi, state)
  static Future<ExotelCallResponse> initiateAiCall({
    required String userPhone,
    String? topic,
    String? language = 'hi',
    String? customQuery,
    Map<String, dynamic>? userProfile,
  }) async {
    final formattedPhone = formatIndianPhoneNumber(userPhone);

    if (!isValidIndianPhoneNumber(userPhone)) {
      return ExotelCallResponse.error(
        'अमान्य मोबाइल नंबर! कृपया 10 अंकों का सही मोबाइल नंबर दर्ज करें। (Invalid 10-digit phone number)',
      );
    }

    if (!isConfigured) {
      if (kDebugMode) {
        print('ExotelService: Credentials not yet configured in app_config.dart. Simulating test call.');
      }
      // Return a simulated success response for development/testing if API key not set yet
      return ExotelCallResponse(
        success: true,
        callSid: 'simulated_call_${DateTime.now().millisecondsSinceEpoch}',
        status: 'queued',
        message: 'डेमो मोड: कॉल सफलतापूर्वक शेड्यूल की गई! (Demo Mode: Call Queued)',
      );
    }

    try {
      final accountSid = AppConfig.exotelAccountSid;
      final apiKey = AppConfig.exotelApiKey;
      final apiToken = AppConfig.exotelApiToken;
      final subdomain = AppConfig.exotelSubdomain;
      final callerId = AppConfig.exotelCallerId;

      final url = Uri.parse('https://$subdomain/v1/Accounts/$accountSid/Calls/connect.json');

      // Basic Authentication
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:$apiToken'))}';

      // Custom metadata payload for the AI Voice Webhook
      final customPayload = jsonEncode({
        'service': 'apnagodam_ai_assistant',
        'topic': topic ?? 'general_query',
        'language': language ?? 'hi',
        'query': customQuery ?? '',
        'userProfile': userProfile ?? {},
        'initiatedAt': DateTime.now().toIso8601String(),
      });

      // Flow URL: If App ID is specified, use Exotel flow URL pattern, otherwise use custom webhook flow URL
      String flowUrl = AppConfig.exotelFlowUrl;
      if (AppConfig.exotelAppId.isNotEmpty &&
          AppConfig.exotelAppId != 'YOUR_EXOTEL_APP_ID') {
        flowUrl = 'http://my.exotel.com/$accountSid/exoml/start_voice/${AppConfig.exotelAppId}';
      }

      final bodyFields = {
        'From': formattedPhone,
        'CallerId': callerId,
        'Url': flowUrl,
        'CustomField': customPayload,
        'CallType': 'trans',
        'TimeLimit': '600', // 10 minutes maximum duration
        'Record': 'true',
      };

      if (kDebugMode) {
        print('ExotelService: Connecting call to $formattedPhone via $url');
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: bodyFields,
      );

      if (kDebugMode) {
        print('ExotelService Response [${response.statusCode}]: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return ExotelCallResponse.fromJson(data);
      } else {
        String errorMsg = 'कॉल कनेक्ट करने में समस्या आई (${response.statusCode})';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map && errorData.containsKey('RestException')) {
            final restEx = errorData['RestException'];
            errorMsg = restEx['Message'] ?? errorMsg;
          }
        } catch (_) {}

        if (response.statusCode == 401) {
          errorMsg = 'Exotel प्रमाणीकरण विफल (Authentication Failed). कृपया API Credentials जांचें।';
        } else if (response.statusCode == 402) {
          errorMsg = 'Exotel बैलेंस समाप्त (Insufficient Balance). कृपया Exotel खाता रिचार्ज करें।';
        }

        return ExotelCallResponse.error(errorMsg);
      }
    } catch (e) {
      if (kDebugMode) {
        print('ExotelService Error: $e');
      }
      return ExotelCallResponse.error('नेटवर्क त्रुटि: $e');
    }
  }

  /// Fetches live status and details of an active or past call
  static Future<ExotelCallResponse> getCallDetails(String callSid) async {
    if (!isConfigured || callSid.startsWith('simulated_')) {
      return ExotelCallResponse(
        success: true,
        callSid: callSid,
        status: 'in-progress',
        message: 'Simulated call in progress',
      );
    }

    try {
      final accountSid = AppConfig.exotelAccountSid;
      final apiKey = AppConfig.exotelApiKey;
      final apiToken = AppConfig.exotelApiToken;
      final subdomain = AppConfig.exotelSubdomain;

      final url = Uri.parse('https://$subdomain/v1/Accounts/$accountSid/Calls/$callSid.json');
      final basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:$apiToken'))}';

      final response = await http.get(
        url,
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return ExotelCallResponse.fromJson(data);
      } else {
        return ExotelCallResponse.error('कॉल विवरण प्राप्त नहीं हो सका (${response.statusCode})');
      }
    } catch (e) {
      return ExotelCallResponse.error('त्रुटि: $e');
    }
  }
}
