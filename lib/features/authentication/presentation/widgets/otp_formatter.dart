import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFormatter extends TextInputFormatter {
  final int maxLength;

  OtpFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= maxLength) {
      return newValue;
    } else {
      final String updatedText = newValue.text.substring(1);
      return TextEditingValue(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
    }
  }
}