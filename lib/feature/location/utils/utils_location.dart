import 'package:flutter/material.dart';

enum BookingStation {
  connect,
  booking,
  charging,
  finishing,
  available
}

class UtilsLocation {
  static final ValueNotifier<String?> _typesConnector = ValueNotifier('GB_T');

  static set setConnector(String? value) {
    _typesConnector.value = value;
  }

  static ValueNotifier<String?> get typesConnector => _typesConnector;

  static final ValueNotifier<int> _typesOfPower = ValueNotifier(150);

  static set setOfPower(int value) {
    _typesOfPower.value = value;
  }

  static ValueNotifier<int> get typesOfPower => _typesOfPower;

  static final ValueNotifier<BookingStation> _processChargingUp =
      ValueNotifier(BookingStation.connect);

  static set setChargingUp(BookingStation value) {
    _processChargingUp.value = value;
  }

  static ValueNotifier<BookingStation> get processChargingUp =>
      _processChargingUp;

  static final ValueNotifier<Widget?> _selectStation = ValueNotifier(null);

  static set setSelectStation(Widget? value) {
    _selectStation.value = value;
  }

  static ValueNotifier<Widget?> get selectStation => _selectStation;

  static final ValueNotifier<int> _index = ValueNotifier(0);

  static set setIndex(int value) {
    _index.value = value;
  }

  static ValueNotifier<int> get index => _index;
}
