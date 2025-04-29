import 'dart:ui';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/circle_container.dart';
import '../../../../share/widgets/item_app_bar.dart';
import '../../utils/utils_location.dart';
import 'item_battery.dart';
import 'item_rate.dart';
import 'item_title.dart';

class SuccessChargingUp extends StatelessWidget {
  const SuccessChargingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ItemTitle(
            title: 'Вы заряжветесь!',
            description: 'Как зарядитесь до нужного уровня нажмите "Завершить"',
            descriptionSupplement: 'Время работы с 00:00 - 24:00',
            id: 'ID 81862612',
            number: '# U71509',
            watt: '41 kBT',
          ),
          8.height,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ItemRate(
                title: 'Тариф',
                description: r'14 $ / кВТ*ч',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Заряжено на:', style: context.textTheme.titleSmall),
                  Text('4.044 kBT', style: context.textTheme.bodyMedium)
                ],
              )
            ],
          ),
          const Divider(),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: ItemBattery()),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColorsDark.greyBorder,
                        shape: BoxShape.circle,
                      ),
                      child: Text(r'18:00',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColorsDark.black,
                          )),
                    ),
                  ),
                  const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.access_time_filled,
                        color: AppColorsDark.green1,
                      ))
                ],
              )
            ],
          ),
          16.height,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  UtilsLocation.setChargingUp = BookingStation.finishCharging;
                },
                child: CircleContainer(
                  color: AppColorsDark.bodyText,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(r'50$ / Завершить',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColorsDark.green3,
                      )),
                ),
              ),
              16.width,
              ItemAppBar(
                icon: 'assets/star_review.png',
                color: AppColorsDark.white,
                colorIcon: AppColorsDark.green3,
                onPressed: () async {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
