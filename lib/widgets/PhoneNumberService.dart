import 'package:flutter/services.dart';

class PhoneNumberService {
  static const platform = MethodChannel('com.example.yourapp/phone');

  static Future<String?> getPhoneNumber() async {
    try {
      final String? phoneNumber = await platform.invokeMethod('getPhoneNumber');
      return phoneNumber;
    } catch (e) {
      return null;
    }
  }
}
