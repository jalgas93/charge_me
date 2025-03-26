import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/circle_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../dashboard/utils/utils_dashboard.dart';
import 'bookiing/booking_container.dart';

class StationOther extends StatelessWidget {
  const StationOther({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'СИТИ ЦЕНТР ТЦ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              8.height,
              Text(
                'Улица Мирзо Улугбекаб Ташкент',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Время работы с 00:00 - 24:00',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              8.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleContainer(
                    child: Text(
                      'ID 81862612',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  8.width,
                  CircleContainer(
                    child: Text(
                      '# U71509',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  8.width,
                  CircleContainer(
                    child: Text(
                      '60 kBT',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              16.height,
              const BookingContainer(),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: (){

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
                        UtilsDashboard.setChange = false;
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
