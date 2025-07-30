import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/app_user.dart';
import '../../../../core/styles/app_colors_dark.dart';
import '../../bloc/websocket/websocket_bloc.dart';
import '../../model/stations.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key, required this.check, required this.connector});

  final Check check;
  final Connector connector;

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  Connector get connector => widget.connector;

  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    return Container(
      margin: const EdgeInsets.only(top: 8,bottom: 8),
      padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
      decoration: const BoxDecoration(
          color: AppColorsDark.secondaryColorW,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ваш очередь: ${widget.check.queue?.position}',
            style: context.textTheme.bodyLarge
                ?.copyWith(color: AppColorsDark.darkStyleText),
          ),
          TextButton(onPressed: (){
            websocketBloc.add(WebsocketEvent.check(
              message: jsonEncode({
                "action": "Check",
                "messageId": "check",
                "payload": {
                  "status": "cancel",
                  "userId": AppUser.userModel?.userId,
                  "connectorId":
                  "${connector.connectorId}"
                }
              }),
            ));
          }, child: Text(
            'Отменить очередь',
            style: context.textTheme.bodyLarge
                ?.copyWith(color: AppColorsDark.blue3),
          ))
        ],
      ),
    );
  }
}
