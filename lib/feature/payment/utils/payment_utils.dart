import 'package:flutter/material.dart';

enum PayType { mastercard, visa, mir, humo, uzcard }

class PaymentUtils {
  static final ValueNotifier<String> _paymentMethod =
      ValueNotifier('mastercard');

  static set setPaymentMethod(String value) {
    _paymentMethod.value = value;
  }

  static ValueNotifier<String> get paymentMethod => _paymentMethod;
}
