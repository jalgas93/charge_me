import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/widget/booking/cancel_active.dart';
import 'package:charge_me/feature/location/widget/booking/cancel_queue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_user.dart';
import '../../../../core/router/router.gr.dart';
import '../../../_app/widgets/custom_button.dart';
import '../../bloc/websocket/websocket_bloc.dart';
import '../../model/stations.dart';
import '../../utils/utils_location.dart';

class ButtonContainer extends StatefulWidget {
  const ButtonContainer(
      {super.key,
      this.queue,
      this.active,
      required this.connector,
      required this.station, this.isLoading,
      });

  final Queue? queue;
  final Active? active;
  final Connector? connector;
  final Station station;
  final bool? isLoading;

  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  late WebsocketBloc _bloc;
  bool? get isLoading => widget.isLoading;

  @override
  void initState() {
    _bloc = BlocProvider.of<WebsocketBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.connector?.status?.toLowerCase()) {
      case 'available':
        return widget.active == null && widget.queue == null
            ? Column(
                children: [
                  8.height,
                  CustomButton(
                    isLoading: isLoading,
                      onTap: () {
                        _bloc.add(WebsocketEvent.booking(
                          message: jsonEncode({
                            "action": "StartBooking",
                            "messageId": "StartBooking",
                            "payload": {
                              "status": BookingStation.booking.name,
                              "phone": AppUser.userModel?.phone,
                              "userId": AppUser.userModel?.userId,
                              "connectorId": "${widget.connector?.connectorId}",
                              "timestamp": DateTime.now().toIso8601String(),
                              "chargerId": widget.station.externalId
                            }
                          }),
                        ));
                      },
                      radius: 25,
                      text: 'Продолжить'),
                ],
              )
            : const SizedBox.shrink();
      case 'booking':
      case 'charging':
      case 'queue':
        if (widget.queue != null && widget.active == null) {
          return Column(
            children: [
              8.height,
              CancelQueue(
                position: widget.queue?.position,
                onQueue: () {
                  _bloc.add(WebsocketEvent.check(
                    message: jsonEncode({
                      "action": "Check",
                      "messageId": "check",
                      "payload": {
                        "message": "cancelQueue",
                        "userId": AppUser.userModel?.userId,
                        "connectorId": "${widget.connector?.connectorId}"
                      }
                    }),
                  ));
                  _bloc.add(WebsocketEvent.connector(
                    message: jsonEncode({
                      "action": "Connector",
                      "messageId": "connector",
                    }),
                  ));
                },
              ),
            ],
          );
        } else if (widget.queue == null && widget.active != null) {
          return Column(
            children: [
              8.height,
              CancelActive(
                connectorId: widget.connector?.connectorId,
                onActive: () {
                  _bloc.add(WebsocketEvent.check(
                    message: jsonEncode({
                      "action": "Check",
                      "messageId": "check",
                      "payload": {
                        "message": "cancelActive",
                        "userId": AppUser.userModel?.userId,
                        "connectorId": "${widget.connector?.connectorId}"
                      }
                    }),
                  ));
                  _bloc.add(WebsocketEvent.connector(
                    message: jsonEncode({
                      "action": "Connector",
                      "messageId": "connector",
                    }),
                  ));
                },
              ),
              8.height,
              CustomButton(
                isLoading: isLoading,
                  onTap: () {
                    context.router.push(BookingRoutePage(
                      connector: widget.connector,
                      station: widget.station,
                      active: widget.active,
                    ));
                    /*_bloc.add(WebsocketEvent.booking(
                                message: jsonEncode({
                                  "action": "StartBooking",
                                  "messageId": "StartBooking",
                                  "payload": {
                                    "status": BookingStation.booking.name,
                                    "phone": AppUser.userModel?.phone,
                                    "userId": AppUser.userModel?.userId,
                                    "connectorId": "${widget.connector.connectorId}",
                                    "timestamp":
                                        DateTime.now().toIso8601String(),
                                    "chargerId": widget.station.externalId
                                  }
                                }),
                              ));*/
                  },
                  radius: 25,
                  text: 'Продолжить')
            ],
          );
        } else if (widget.queue == null) {
          return Column(
            children: [
              8.height,
              CustomButton(
                isLoading: isLoading,
                  onTap: () {
                    _bloc.add(WebsocketEvent.queue(
                      message: jsonEncode({
                        "action": "Queue",
                        "messageId": "queue",
                        "payload": {
                          "status": BookingStation.queue.name,
                          "phone": AppUser.userModel?.phone,
                          "userId": AppUser.userModel?.userId,
                          "connectorId": "${widget.connector?.connectorId}",
                          "timestamp": DateTime.now().toIso8601String(),
                        }
                      }),
                    ));
                  },
                  radius: 25,
                  text: 'Встать в очередь'),
            ],
          );
        } else if (widget.queue != null) {
          return Column(
            children: [
              8.height,
              CancelQueue(
                position: widget.queue?.position,
                onQueue: () {
                  _bloc.add(WebsocketEvent.check(
                    message: jsonEncode({
                      "action": "Check",
                      "messageId": "check",
                      "payload": {
                        "message": "cancelQueue",
                        "userId": AppUser.userModel?.userId,
                        "connectorId": "${widget.connector?.connectorId}"
                      }
                    }),
                  ));
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      case 'unavailable':
        return AnimatedOpacity(
          opacity: 0.5,
          duration: const Duration(microseconds: 500),
          child: Column(
            children: [
              16.height,
              CustomButton(
                isLoading: isLoading,
                  onTap: () {},
                  radius: 25,
                  text: 'Продолжить'),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
