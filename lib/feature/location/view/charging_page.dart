import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/circle_container.dart';
import '../../../../share/widgets/item_app_bar.dart';
import '../../../core/helpers/app_user.dart';
import '../../../core/provider/websocket_provider.dart';
import '../../../share/widgets/count_down.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_battery.dart';
import '../widget/booking/item_rate.dart';
import '../widget/booking/item_title.dart';

class ChargingPage extends StatefulWidget {
  const ChargingPage({
    super.key,
    this.station,
    this.onTapReview,
    required this.payloadStartTransaction,
  });

  final Station? station;
  final Function()? onTapReview;
  final PayloadStartTransaction payloadStartTransaction;

  @override
  State<ChargingPage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<ChargingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int levelClock = 3 * 60;
  List<Connector>? get connector => Provider.of<ConnectorProviderData>(context,listen: false).connector;
  PayloadStartTransaction get response => widget.payloadStartTransaction;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ItemTitle(
            title: 'Вы заряжветесь!',
            description: 'Как зарядитесь до нужного уровня нажмите "Завершить"',
            descriptionSupplement: 'Время работы с 00:00 - 24:00',
            stationId: widget.station?.externalId ?? '',
            connectorId:
                '# ${connector?[UtilsLocation.index.value].connectorId}',
            maxPower: '${connector?[UtilsLocation.index.value].maxPower} kBT',
          ),
          8.height,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemRate(
                title: 'Тариф',
                description:
                    '${connector?[UtilsLocation.index.value].costPerKwh?.toStringAsFixed(0)} sum / кВТ*ч',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Заряжено на:', style: context.textTheme.titleSmall),
                  Text(
                      '${connector?[UtilsLocation.index.value].energyConsumed} kBT',
                      style: context.textTheme.bodyMedium)
                ],
              )
            ],
          ),
          const Divider(),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: ItemBattery()),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColorsDark.greyBorder,
                        shape: BoxShape.circle,
                      ),
                      child: Countdown(
                        animation: StepTween(
                          begin: levelClock,
                          // THIS IS A USER ENTERED NUMBER
                          end: 0,
                        ).animate(_animationController!),
                      ),
                    ),
                  ),
                  const Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.access_time_filled,
                        color: AppColorsDark.green1,
                      ))
                ],
              )
            ],
          ),
          16.height,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  websocketBloc.add(WebsocketEvent.finish(
                      message: jsonEncode({
                    "action": "StopTransaction",
                    "messageId": "stopTransaction",
                    "payload": {
                      "transactionId": response.transactionId,
                      "status": BookingStation.finishing.name,
                      "userId":AppUser.userModel?.userId,
                      "connectorId": "${connector?[UtilsLocation.index.value].connectorId}",
                      "timestamp": DateTime.now().toIso8601String(),
                      "endTime": DateTime.now().toIso8601String(),
                      "chargerId": widget.station?.externalId,
                      "energyConsumed": 50,
                      "cost": 35.5
                    }
                  })));
                },
                child: CircleContainer(
                  color: AppColorsDark.bodyText,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text('${connector?[UtilsLocation.index.value].energyConsumed} sum / Завершить',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColorsDark.green3,
                      )),
                ),
              ),
              16.width,
              ItemAppBar(
                icon: 'assets/star_review.png',
                color: AppColorsDark.white,
                colorIcon: AppColorsDark.green3,
                onPressed: () async {
                  print("time ${DateTime.now().millisecondsSinceEpoch}");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
