import 'dart:async';

import 'package:flutter/material.dart';

class BookingService {
  static const int pricePerMinute = 100; // 100 сум за минуту

  // Таймер для обновления стоимости
  Timer? _timer;
  int _minutes = 0;
  ValueNotifier<int> currentCost = ValueNotifier(0);
  ValueNotifier<String> formattedTime = ValueNotifier('00:00');

  // Начать бронирование
  void startBooking() {
    _minutes = 0;
    _updateTimeAndCost();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _minutes++;
      _updateTimeAndCost();
    });
  }

  // Остановить бронирование
  void stopBooking() {
    _timer?.cancel();
    _sendBookingToServer();
  }

  // Обновить время и стоимость
  void _updateTimeAndCost() {
    currentCost.value = _minutes * pricePerMinute;
    formattedTime.value =
        '${_minutes ~/ 60}'.padLeft(2, '0') +
            ':' +
            '${_minutes % 60}'.padLeft(2, '0');
  }

  // Отправить данные на сервер
  void _sendBookingToServer() {
    final bookingData = {
      'duration_minutes': _minutes,
      'total_cost': currentCost.value,
      'timestamp': DateTime.now().toIso8601String(),
    };
    print('Отправка данных бронирования: $bookingData');
    // Здесь реализуйте вызов API
  }
}

/*
final bookingService = BookingService();

// В build():
Column(
  children: [
    ValueListenableBuilder(
      valueListenable: bookingService.formattedTime,
      builder: (_, time, __) => Text('Время: $time'),
    ),
    ValueListenableBuilder(
      valueListenable: bookingService.currentCost,
      builder: (_, cost, __) => Text('Стоимость: $cost сум'),
    ),
    ElevatedButton(
      onPressed: bookingService.startBooking,
      child: Text('Начать бронирование'),
    ),
    ElevatedButton(
      onPressed: bookingService.stopBooking,
      child: Text('Завершить'),
    ),
  ],
)
 */