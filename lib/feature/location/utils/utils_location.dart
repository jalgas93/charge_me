import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

enum BookingStation{
  initialBooking,
  successBooking,
  successChargingUp,
  finishCharging,
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

  static final ValueNotifier<BookingStation> _processChargingUp = ValueNotifier(BookingStation.initialBooking);

  static set setChargingUp(BookingStation value) {
    _processChargingUp.value = value;
  }

  static ValueNotifier<BookingStation> get processChargingUp => _processChargingUp;

}
