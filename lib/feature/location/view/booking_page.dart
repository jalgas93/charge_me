import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/helpers/app_helper.dart';
import 'package:charge_me/core/provider/websocket_provider.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:charge_me/feature/location/utils/booking_service.dart';
import 'package:charge_me/feature/location/view/charging_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/app_user.dart';
import '../../auth/widget/title_text.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/button_booking.dart';
import '../widget/booking/item_success_booking.dart';
import '../widget/item_title.dart';

@RoutePage(name: 'BookingRoutePage')
class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    this.active,
    this.station,
    required this.connector,
  });

  final Active? active;
  final Station? station;
  final Connector? connector;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // String _extId = AppHelper.getRandomUuid();
  Station? get station => widget.station;

  Connector? get connector => widget.connector;

  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Бронирование'.toUpperCase(),
            style: context.textTheme.titleMedium),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                ItemSuccessBooking(
                    type: connector?.type ?? '',
                    price: connector?.costPerKwh ?? 0,
                    costBookingMinutes: connector?.costBookingMinutes ?? 0,
                connectorId: connector?.connectorId ??'',
                ),
                16.height,
                ValueListenableBuilder(
                    valueListenable: UtilsLocation.formatedTime,
                    builder: (context,value,child){
                      return Text('Отмена брони автоматически через 20 мин: ${value?.substring(3,8)}');
                    }),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonBooking(
                      name: 'Отменить бронь',
                      containerColor: AppColorsDark.white,
                      nameColor: AppColorsDark.green3,
                      onTap: () {
                        websocketBloc.add(WebsocketEvent.check(
                          message: jsonEncode({
                            "action": "Check",
                            "messageId": "check",
                            "payload": {
                              "message": "cancelActive",
                              "userId": AppUser.userModel?.userId,
                              "connectorId": "${connector?.connectorId}"
                            }
                          }),
                        ));
                        context.router.popForced();
                      },
                    ),
                    8.width,
                    ValueListenableBuilder(
                      valueListenable: UtilsLocation.currentCost,
                      builder: (context,cost,child){
                        return ValueListenableBuilder(
                          valueListenable: UtilsLocation.timeNotFree,
                          builder: (context,time,child){
                            return ButtonBooking(
                              name: 'Зарядиться',
                              containerColor: AppColorsDark.green1,
                              nameColor: AppColorsDark.white,
                              onTap: () {
                                websocketBloc.add(WebsocketEvent.charging(
                                  message: jsonEncode({
                                    "action": "StartTransaction",
                                    "messageId": "startTransaction",
                                    "payload": {
                                      "status": BookingStation.charging.name,
                                      "bookingCost": "$cost",
                                      "bookingTime": "$time",
                                      "connectorId": "${connector?.connectorId}",
                                      "timestamp": DateTime.now().toIso8601String()
                                    }
                                  }),
                                ));
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
