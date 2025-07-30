import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/widget/booking/timer_booking.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../_app/utils/charge_bottom_sheet.dart';
import '../../../_app/widgets/circle_container.dart';
import '../../utils/helper_charging.dart';
import 'item_rate.dart';

class ItemSuccessBooking extends StatelessWidget {
  const ItemSuccessBooking(
      {super.key,
      required this.type,
      required this.price,
      required this.costBookingMinutes,
        required this.connectorId,
 });

  final String type;
  final num price;
  final int costBookingMinutes;
  final String connectorId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemRate(
              title: 'Тариф',
              description: '${price.toStringAsFixed(0)} тенге / kWh',
            ),
            CircleContainer(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              color: AppColorsDark.green1,
              child: Text(Charging().connectorType(type: type),
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColorsDark.white)),
            ),
          ],
        ),
        16.height,
        const Divider(),
        16.height,
        TimerBooking(costBookingMinutes: costBookingMinutes,
        connectorId: connectorId,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/rout.png'),
                8.width,
                TextButton(
                    onPressed: () async{
                      final availableMaps = await MapLauncher.installedMaps;
                      await ChargeBottomSheet.showInMap(
                          context: context,
                        latitude: 41.298727,
                        longitude: 69.277398,
                        availableMaps: availableMaps);

                    },
                    child: Text('Построить маршрут',
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: Colors.green))),
              ],
            ),
            const Divider()
          ],
        )
      ],
    );
  }
}
