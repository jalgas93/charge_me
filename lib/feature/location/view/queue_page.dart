import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/app_user.dart';
import '../../../core/provider/websocket_provider.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/circle_container.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_rate.dart';
import '../widget/booking/item_title.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key, this.station});

  final Station? station;

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  List<Connector>? get connector => Provider.of<ConnectorProviderData>(context,listen: false).connector;

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
                              "phone": AppUser.userModel?.phone,
                              "userId":AppUser.userModel?.userId,
                              "connectorId":"${connector?[UtilsLocation.index.value].connectorId}",
                              "timestamp":
                              DateTime.now().toIso8601String(),
                              "chargerId": widget.station?.externalId ??'STS_1'
                            }
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
