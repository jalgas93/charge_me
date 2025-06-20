import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/share/widgets/circle_container.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/count_down.dart';
import 'item_rate.dart';

class ItemSuccessBooking extends StatelessWidget {
  const ItemSuccessBooking(
      {super.key,
      required this.type,
      required this.price,
      required this.levelClock,
      required this.animation,
        required this.costBookingMinutes});

  final String type;
  final num price;
  final int levelClock;
  final   AnimationController animation;
  final num costBookingMinutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemRate(
              title: 'Тариф',
              description: '${price.toStringAsFixed(0)} sum / кВТ*ч',
            ),
            CircleContainer(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              color: AppColorsDark.green1,
              child: Text(type,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColorsDark.white)),
            ),
          ],
        ),
        16.height,
        const Divider(),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Бесплатное бронирование',
                    style: context.textTheme.titleSmall),
                Row(
                  children: [
                    Text('Осталось', style: context.textTheme.bodyMedium),
                    10.width,
                    Countdown(
                      animation: StepTween(
                        begin: levelClock,
                        // THIS IS A USER ENTERED NUMBER
                        end: 0,
                      ).animate(animation as Animation<double>),
                    )
                  ],
                )
              ],
            ),
            Text('${costBookingMinutes.toStringAsFixed(0)} sum', style: context.textTheme.titleLarge),
          ],
        ),
        16.height,
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                  color: AppColorsDark.green0,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Text(
                'Вставьте коннектор в разъем электромобиля и подтвердите подключение',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColorsDark.black),
              ),
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/rout.png'),
                8.width,
                Text('Построить маршрут',
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: Colors.green)),
              ],
            ),
            16.height,
            const Divider()
          ],
        )
      ],
    );
  }
}
