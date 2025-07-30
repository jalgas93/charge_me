import 'dart:async';

import 'package:flutter/material.dart';

class BookingService {
  static const int pricePerMinute = 500; // 500 сум за минуту

  // Таймер для обновления стоимости
  Timer? _timer;
  int _seconds = 0;
  final ValueNotifier<int> currentCost = ValueNotifier(0);
  final ValueNotifier<String> formattedTime = ValueNotifier('00:00:00');

  // Начать бронирование
  void startBooking() {
    _seconds = 0;
    _updateTimeAndCost();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      _updateTimeAndCost();
    });
  }

  // Остановить бронирование
  void stopBooking() {
    _sendBookingToServer();
  }
  // Отменить таймер
  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
  // Обновить время и стоимость
  void _updateTimeAndCost() {
    final hours = _seconds ~/ 3600;
    final minutes = (_seconds % 3600) ~/ 60;
    final seconds = _seconds % 60;

    currentCost.value = (_seconds / 60).ceil() * pricePerMinute;
    formattedTime.value = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  // Отправить данные на сервер
  void _sendBookingToServer() {
    final _minutes = (_seconds / 60).ceil();
    final bookingData = {
      'duration_seconds': _seconds,
      'duration_minutes': _minutes,
      'total_cost': currentCost.value,
      'timestamp': DateTime.now().toIso8601String(),
    };
    print('Отправка данных бронирования: $bookingData');
    // Здесь реализуйте вызов API
  }
  void dispose() {
    _cancelTimer();
    currentCost.dispose();
    formattedTime.dispose();
  }
}
