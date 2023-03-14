import 'package:flutter/services.dart';

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String input = newValue.text.replaceAll("/", "");

    String formatted = '';
    for (var i = 0; i < input.length; i++) {
      if (i == 2) {
        formatted += '/';
      }
      formatted += input[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}