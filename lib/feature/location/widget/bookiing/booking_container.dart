import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/share/widgets/circle_container.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/item_app_bar.dart';

class BookingContainer extends StatelessWidget {
  const BookingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ItemAppBar(
                  icon: 'assets/battery_charging.png',
                  color: AppColorsDark.green0,
                  colorIcon: AppColorsDark.green3,
                  colorBorder: AppColorsDark.green0,
                  onPressed: () async {},
                ),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Тариф', style: context.textTheme.titleSmall),
                    Text(r'14 $ / кВТ*ч', style: context.textTheme.bodyMedium)
                  ],
                )
              ],
            ),
            CircleContainer(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              color: AppColorsDark.green1,
              child: Text('Type 1',
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
                Text('Осталось ${14}', style: context.textTheme.bodyMedium)
              ],
            ),
            Text(r'14 $',
                style: context.textTheme.titleLarge),
          ],
        ),
        16.height,
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                  color: AppColorsDark.green0,
                  borderRadius:  BorderRadius.all(Radius.circular(16))),
              child: Text(
                'Вставьте коннектор в разъем электромобиля и подтвердите подключение',
                style: context.textTheme.bodyLarge?.copyWith(color: AppColorsDark.black),
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
