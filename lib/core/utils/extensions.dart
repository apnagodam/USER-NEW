extension ValidMobileNumber on String {
  bool isValidMobileNumber() {
    final RegExp mobileRegex = RegExp(r'^[1-9]\d{9}$');
    return mobileRegex.hasMatch(this);
  }
}
