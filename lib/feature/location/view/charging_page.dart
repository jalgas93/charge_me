import 'dart:convert';
import 'dart:ffi';

import 'package:auto_route/annotations.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/widget/charging/timer_charging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../core/helpers/app_user.dart';
import '../../_app/utils/charge_bottom_sheet.dart';
import '../../_app/view/review/view/add_review_page.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../auth/widget/title_text.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/button_booking.dart';
import '../widget/booking/item_battery.dart';
import '../widget/booking/item_rate.dart';
import '../widget/finish/result_container.dart';
import '../widget/item_title.dart';

@RoutePage(name: 'ChargingRoutePage')
class ChargingPage extends StatefulWidget {
  const ChargingPage({
    super.key,
    this.station,
    this.onTapReview,
    required this.payloadStartTransaction,
    required this.connector,
  });

  final Connector? connector;
  final Station? station;
  final Function()? onTapReview;
  final PayloadStartTransaction payloadStartTransaction;

  @override
  State<ChargingPage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<ChargingPage> {
  Station? get station => widget.station;
  Connector? get connector => widget.connector;
  PayloadStartTransaction get response => widget.payloadStartTransaction;

  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Charging'.toUpperCase()),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const TitleText(
              title: 'Краткое описание:',
              description:
                  'Страница позволяет пользователям выбрать, забронировать и оплатить зарядную станцию для электромобиля.',
            ),
            const Spacer(),
            ItemTitle(
              title: '${station?.location?.city}',
              description: '${station?.location?.address}',
              descriptionSupplement: 'Время работы с 00:00 - 24:00',
              stationId: '${station?.externalId}',
              connector: connector,
            ),
            8.height,
            const Divider(),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemRate(
                  title: 'Тариф',
                  description:
                      '${connector?.costPerKwh?.toStringAsFixed(0)} тенге / kWh',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Заряжено на:', style: context.textTheme.titleSmall),
                    Text('${connector?.energyConsumed} kW',
                        style: context.textTheme.bodyMedium)
                  ],
                )
              ],
            ),
            8.height,
            const Divider(),
            8.height,
            ResultContainer(
              title: "Начало зарядки",
              description: DateFormat('dd.MM.yyyy HH:mm')
                  .format(response.currentTime!),
            ),
            8.height,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: ItemBattery()), TimerCharging()],
            ),
            16.height,
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: UtilsLocation.time,
                    builder: (context, value, child) {
                      return ButtonBooking(
                        onTap: () {
                          websocketBloc.add(
                            WebsocketEvent.finish(
                              message: jsonEncode({
                                "action": "StopTransaction",
                                "messageId": "stopTransaction",
                                "payload": {
                                  "userId": AppUser.userModel?.userId,
                                  "transactionId": response.transactionId,
                                  "status": BookingStation.finishing.name,
                                  "connectorId": "${connector?.connectorId}",
                                  "timestamp": DateTime.now().toIso8601String(),
                                  "endTime": DateTime.now().toIso8601String(),
                                  "durationTime": "$value",
                                  "energyConsumed": 50,
                                  "cost": 35.5
                                }
                              }),
                            ),
                          );
                        },
                        containerColor: AppColorsDark.green1,
                        nameColor: AppColorsDark.white,
                        name: '${connector?.energyConsumed} тенге / Завершить',
                      );
                    },
                  ),
                  16.width,
                  ItemAppBar(
                    icon: 'assets/star_review.png',
                    color: AppColorsDark.white,
                    colorIcon: AppColorsDark.yellow1,
                    onPressed: () async {
                      await ChargeBottomSheet.draggableScrollableSheet(
                          context: context, children: [const AddReviewPage()]);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}