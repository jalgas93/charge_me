import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

enum TypesConnector {
  chademo,
  ccs1,
  ccs2,
  type1,
  type2,
  gbt,
  tesla,
  j1772type1,
  combo1,
  combo2,
}

class UtilsLocation {
  static final ValueNotifier<String> _typesConnector = ValueNotifier('CHAdeMo');

  static set setConnector(String value) {
    _typesConnector.value = value;
  }

  static ValueNotifier<String> get typesConnector => _typesConnector;

  static final ValueNotifier<int> _typesOfPower = ValueNotifier(150);

  static set setOfPower(int value) {
    _typesOfPower.value = value;
  }

  static ValueNotifier<int> get typesOfPower => _typesOfPower;

}
