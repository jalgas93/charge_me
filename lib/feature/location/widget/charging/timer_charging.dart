import 'dart:async';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../utils/utils_location.dart';

class TimerCharging extends StatefulWidget {
  const TimerCharging({super.key});

  @override
  State<TimerCharging> createState() => _TimerChargingState();
}

class _TimerChargingState extends State<TimerCharging> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
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

    UtilsLocation.setTime = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColorsDark.greyBorder,
            shape: BoxShape.circle,
          ),
          child: ValueListenableBuilder(
            valueListenable: UtilsLocation.time,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '$value',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColorsDark.darkStyleText),
                ),
              );
            },
          ),
        ),
        const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.access_time_filled,
              color: AppColorsDark.darkStyleText,
            )),
        Positioned(
            left: 0,
            right: 0,
            top: 6,
            child: Align(
                alignment: Alignment.center,
                child: Text('Время',
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: AppColorsDark.darkStyleText))))
      ],
    );
  }
}
