import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/helpers/app_helper.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_user.dart';
import '../../bloc/websocket/websocket_bloc.dart';

class TimerBooking extends StatefulWidget {
  const TimerBooking({
    super.key,
    required this.costBookingMinutes,
    required this.connectorId,
  });

  final int costBookingMinutes;
  final String connectorId;

  @override
  State<TimerBooking> createState() => _TimerBookingState();
}

class _TimerBookingState extends State<TimerBooking> {
  late WebsocketBloc _bloc;
  Timer? _timer;

  int get pricePerMinute => widget.costBookingMinutes;
  int _seconds = 0;
  int _secondsNotFree = 0;

  @override
  void initState() {
    _bloc = BlocProvider.of<WebsocketBloc>(context);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      if (_seconds > 300) {
        _secondsNotFree++;
        _updateTimeNotFree();
      }
      if (_seconds > 1200) {
        _cancelBooking();
      }
      _updateTimeAndCost();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTimeAndCost() {
    final hours = _seconds ~/ 3600;
    final minutes = (_seconds % 3600) ~/ 60;
    final seconds = _seconds % 60;

    UtilsLocation.setCurrentCost =
        (_secondsNotFree / 60).ceil() * pricePerMinute;

    UtilsLocation.setFormatedTime = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void _updateTimeNotFree() {
    final hours = _secondsNotFree ~/ 3600;
    final minutes = (_secondsNotFree % 3600) ~/ 60;
    final seconds = _secondsNotFree % 60;

    UtilsLocation.setTimeNotFree = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void _cancelBooking() {
    _timer?.cancel();
    _bloc.add(WebsocketEvent.check(
      message: jsonEncode({
        "action": "Check",
        "messageId": "check",
        "payload": {
          "message": "cancelActive",
          "userId": AppUser.userModel?.userId,
          "connectorId": widget.connectorId
        }
      }),
    ));
    _bloc.add(WebsocketEvent.connector(
      message: jsonEncode({
        "action": "Connector",
        "messageId": "connector",
      }),
    ));
    context.router.popForced();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Бронирование', style: context.textTheme.titleSmall),
            Text('Минута:', style: context.textTheme.bodyMedium),
            Row(
              children: [
                Text('Бесплатное время: ', style: context.textTheme.bodyMedium),
                const Text('00:05:00')
              ],
            ),
            Row(
              children: [
                Text('Платное время: ', style: context.textTheme.bodyMedium),
                ValueListenableBuilder(
                  valueListenable: UtilsLocation.formatedTime,
                  builder: (context, value, child) {
                    return Text('$value');
                  },
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Стоимость', style: context.textTheme.titleSmall),
            Text('$pricePerMinute тенге'),
            Text('${0.asCurrencyNoDecimal} тенге'),
            ValueListenableBuilder(
              valueListenable: UtilsLocation.currentCost,
              builder: (context, value, child) {
                return Text('${value?.asCurrencyNoDecimal} тенге');
              },
            ),
          ],
        ),
      ],
    );
  }
}
