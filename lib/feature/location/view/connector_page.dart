import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:charge_me/share/widgets/throw_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/custom_button.dart';
import '../../../core/helpers/app_user.dart';
import '../../../core/provider/websocket_provider.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../widget/booking/item_title.dart';
import '../widget/color_file.dart';

class ConnectorPage extends StatefulWidget {
  const ConnectorPage({super.key, required this.station});

  final Station station;

  @override
  State<ConnectorPage> createState() => _ConnectorPageState();
}

class _ConnectorPageState extends State<ConnectorPage> {

  void _submit(){

  }
  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    List<Connector>? connector =
        Provider.of<ConnectorProviderData>(context, listen: false).connector;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemTitle(
                title: '${widget.station.location?.city}',
                description: '${widget.station.location?.address}',
                descriptionSupplement: 'Время работы с 00:00 - 24:00',
                stationId: '${widget.station.externalId}',
              ),
              8.height,
              const Divider(),
              8.height,
              Text(
                'Типы зарядных устройств',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.height,
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth / 2.8,
                child: ListView.separated(
                  itemCount: connector!.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        UtilsLocation.setConnector = connector[index].type;
                        UtilsLocation.setIndex = index;
                        UtilsLocation.setStatus = connector[index].status?.toLowerCase();
                      },
                      child: ValueListenableBuilder(
                        valueListenable: UtilsLocation.typesConnector,
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                                color: value == connector[index].type
                                    ? context.theme.focusColor
                                    : AppColorsDark.black,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${connector[index].type}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                8.width,
                                Text(
                                  '${connector[index].status?.toUpperCase()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: ColorFile().statusColor(
                                              status: connector[index]
                                                      .status
                                                      ?.toUpperCase() ??
                                                  '')),
                                ),
                                if (connector[index].status == "booking")
                                  Text(
                                    '${connector[index].blockedBy}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: value == connector[index].type
                                              ? AppColorsDark.white
                                              : AppColorsDark.yellow1,
                                        ),
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${connector[index].maxPower} kBT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color:
                                                value == connector[index].type
                                                    ? AppColorsDark.white
                                                    : AppColorsDark.green1,
                                          ),
                                    ),
                                    Text(
                                      '${connector[index].costPerKwh?.toStringAsFixed(0)} Sum / кВТ*ч',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: value == connector[index]
                                                ? AppColorsDark.white
                                                : AppColorsDark.white,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const SizedBox(width: 8);
                  },
                ),
              ),
              8.height,
              const Divider(),
              8.height,
              ValueListenableBuilder(
                  valueListenable: UtilsLocation.status,
                  builder: (context,value,child){
                    print('value ${value}');
                     switch(value){
                       case 'available':
                         return CustomButton(
                             onTap: () async {
                                 websocketBloc.add(WebsocketEvent.booking(
                                   message: jsonEncode({
                                     "action": "StartBooking",
                                     "messageId": "StartBooking",
                                     "payload": {
                                       "status": BookingStation.booking.name,
                                       "phone": AppUser.userModel?.phone,
                                       "userId": AppUser.userModel?.userId,
                                       "connectorId":
                                       "${connector[UtilsLocation.index.value].connectorId}",
                                       "timestamp": DateTime.now().toIso8601String(),
                                       "chargerId": widget.station.externalId
                                     }
                                   }),
                                 ));
                             },
                             radius: 25,
                             text: 'Продолжить');
                       case 'booking':
                         return CustomButton(
                             onTap: () async {
                               if(connector[UtilsLocation.index.value].queues ==null){
                                 websocketBloc.add(WebsocketEvent.queue(
                                   message: jsonEncode({
                                     "action": "Queue",
                                     "messageId": "QueueMessage",
                                     "payload": {
                                       "status": BookingStation.queue.name,
                                       "phone": AppUser.userModel?.phone,
                                       "userId": AppUser.userModel?.userId,
                                       "connectorId":
                                       "${connector[UtilsLocation.index.value].connectorId}",
                                       "timestamp": DateTime.now().toIso8601String(),
                                     }
                                   }),
                                 ));
                               }
                             },
                             radius: 25,
                             text: 'Встать в очередь');
                       default:
                         return const SizedBox.shrink();
                    }
                  }),
            ],
          );
        },
      ),
    );
  }
}
