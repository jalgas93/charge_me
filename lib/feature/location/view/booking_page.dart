import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/helpers/app_helper.dart';
import 'package:charge_me/core/provider/websocket_provider.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/app_user.dart';
import '../../../share/widgets/circle_container.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_success_booking.dart';
import '../widget/booking/item_title.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    this.station,
  });

  final Station? station;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  String _extId = AppHelper.getRandomUuid();
  int levelClock = 3 * 60;

  List<Connector>? get connector => Provider.of<ConnectorProviderData>(context,listen: false).connector;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ItemTitle(
                    title: widget.station?.location?.city ?? '',
                    description: widget.station?.location?.address ?? '',
                    stationId: widget.station?.externalId ?? '',
                    connectorId:
                        '# ${connector?[UtilsLocation.index.value].connectorId}',
                    type: connector?[UtilsLocation.index.value].type ?? '',
                    maxPower:
                        '${connector?[UtilsLocation.index.value].maxPower} kBT',
                  ),
                  16.height,
                  ItemSuccessBooking(
                    type: connector?[UtilsLocation.index.value].type ?? '',
                    price: connector?[UtilsLocation.index.value].costPerKwh ?? 0,
                    costBookingMinutes: connector?[UtilsLocation.index.value]
                            .costBookingMinutes ??
                        0,
                    levelClock: levelClock,
                    animation: _animationController!,
                  ),
                ],
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        websocketBloc.add(WebsocketEvent.bookingCancel(
                          message: jsonEncode({
                            "action": "CancelBooking",
                            "messageId": "cancelBooking",
                            "payload": {
                              "status": BookingStation.available.name,
                              "booking": AppUser.userModel?.phone,
                              "userId":AppUser.userModel?.userId,
                              "connectorId":"${connector?[UtilsLocation.index.value].connectorId}",
                              "timestamp":
                              DateTime.now().toIso8601String(),
                              "chargerId": widget.station?.externalId ??'STS_1'
                            }
                          }),
                        ));
                        websocketBloc.add(WebsocketEvent.connector(
                          message: jsonEncode({
                            "action": "Connector",
                            "messageId": "connector",
                          }),
                        ));
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
                      onTap: () {
                        websocketBloc.add(WebsocketEvent.charging(
                          message: jsonEncode({
                            "action": "StartTransaction",
                            "messageId": "startTransaction",
                            "payload": {
                              "status": BookingStation.charging.name,
                              "connectorId": "${connector?[UtilsLocation.index.value].connectorId}",
                              "timestamp": DateTime.now().toIso8601String(),
                              "chargerId": widget.station?.externalId,
                              "energyConsumed": 0
                            }
                          }),
                        ));
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
/*
                       onTapCancel: () async {
                            UtilsLocation.setChargingUp =
                                BookingStation.connect;
                            /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StopBooking"}));*/
                          },
                          onTapCharging: () async {
                           // _websocketBloc.add(const WebsocketEvent.charging());
                            /*         await WebSocketManager()
                                                .transmit(jsonEncode({"action": "StartTransaction"}));*/
                          },
 */
