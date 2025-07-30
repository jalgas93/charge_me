import 'package:charge_me/feature/location/model/stations.dart';
import 'package:flutter/material.dart';

enum BookingStation { connect, booking, charging, finishing, available, queue }

class UtilsLocation {
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

  static final ValueNotifier<String?> _message = ValueNotifier(null);

  static set setMessage(String? value) {
    _message.value = value;
    Future.delayed(const Duration(seconds: 5), () {
      _message.value = null;
    });
  }

  static ValueNotifier<String?> get message => _message;

  static final ValueNotifier<bool> _isBlocked = ValueNotifier(true);

  static set setIsBlocked(bool value) {
    _isBlocked.value = value;
  }

  static ValueNotifier<bool> get isBlocked => _isBlocked;

/*  static final ValueNotifier<Connector?> _selectConnector = ValueNotifier(null);

  static set setSelectConnector(Connector? value) {
    _selectConnector.value = value;
  }

  static ValueNotifier<Connector?> get selectConnector => _selectConnector;*/

  static final ValueNotifier<int?> _currentCost = ValueNotifier(0);

  static set setCurrentCost(int? value) {
    _currentCost.value = value;
  }

  static ValueNotifier<int?> get currentCost => _currentCost;

  static final ValueNotifier<String?> _formatedTime =
  ValueNotifier('00:00:00');

  static set setFormatedTime(String? value) {
    _formatedTime.value = value;
  }

  static ValueNotifier<String?> get formatedTime => _formatedTime;

  static final ValueNotifier<String?> _timeNotFree =
  ValueNotifier('00:00:00');

  static set setTimeNotFree(String? value) {
    _timeNotFree.value = value;
  }

  static ValueNotifier<String?> get timeNotFree => _timeNotFree;

  static final ValueNotifier<String?> _time =
  ValueNotifier('00:00:00');

  static set setTime(String? value) {
    _time.value = value;
  }

  static ValueNotifier<String?> get time => _time;

}
