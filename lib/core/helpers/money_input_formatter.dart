

import 'package:charge_me/core/helpers/app_helper.dart';
import 'package:flutter/services.dart';

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length >= 19){
      return oldValue;
    }
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = int.parse(newValue.text);
    final newText = value.asCurrencyNoDecimal;

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
