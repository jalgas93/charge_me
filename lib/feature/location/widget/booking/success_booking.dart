import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../../share/widgets/circle_container.dart';
import '../../utils/utils_location.dart';
import 'item_success_booking.dart';
import 'item_title.dart';

class SuccessBooking extends StatelessWidget {
  const SuccessBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ItemTitle(
                title: 'СИТИ ЦЕНТР ТЦ',
                description: 'Улица Мирзо Улугбекаб Ташкент',
                id: 'ID 81862612',
                number: '# U71509',
                watt: '60 kBT',
              ),
              16.height,
              const ItemSuccessBooking(),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        UtilsLocation.setChargingUp = BookingStation.initialBooking;
                      },
                      child: CircleContainer(
                        color: AppColorsDark.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text('Отменить бронь',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColorsDark.green3,
                            )),
                      ),
                    ),
                  ),
                  8.width,
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        UtilsLocation.setChargingUp = BookingStation.successChargingUp;
                      },
                      child: CircleContainer(
                        color: AppColorsDark.green1,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/power_socket.png',
                              color: AppColorsDark.white,
                            ),
                            8.width,
                            Text('Зарядиться',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(color: AppColorsDark.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
