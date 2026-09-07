import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

extension NumberParsing on String? {
  double convertToDouble({dynamic defaultValue = 0}) {
    return double.parse("${this ?? 0.0}");
  }

  int convertToInt({dynamic defaultValue = 0}) {
    return int.parse("${this ?? 0}");
  }
}

extension CurrencyFormat on String? {
  String? formatCurrency() {
    return NumberFormat.currency(
            locale: 'HI', symbol: '\u{20B9}', decimalDigits: 2)
        .format(this ?? "0.0");
  }
}

extension AadharNumberValidator on String {
  bool isValidAadharNumber() {
    return RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(this);
  }
}

extension PanCardValidator on String {
  bool isValidPanCardNo() {
    return RegExp(r'^[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}$').hasMatch(this);
  }
}

extension BankAccountValidator on String {
  bool isValidBankAccount() {
    return RegExp(r'^\d{10,16}$').hasMatch(this);
  }
}

extension DrivingLicenseValidator on String {
  bool isValidLicenseNo() {
    return RegExp(
            r'^(([a-zA-Z]{2}[0-9]{2})( )|([a-zA-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$')
        .hasMatch(this);
  }
}

extension toast on BuildContext {
  errorToast(String text) => showErrorAlertDialog(this, text);

  successToast(String text) => Fluttertoast.showToast(
      msg: text, backgroundColor: Colors.green, toastLength: Toast.LENGTH_LONG);
}

extension loader on BuildContext {
  showLoader() => showDialog(
      context: this,
      builder: (dialogContext) => Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Lottie.asset(
                ImageConstant.imgisloding,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ));

  hideloader() => Navigator.of(this).pop();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
