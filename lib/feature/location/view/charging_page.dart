import 'dart:convert';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/circle_container.dart';
import '../../../../share/widgets/item_app_bar.dart';
import '../../../core/helpers/app_helper.dart';
import '../../../core/network/http/websocket_client.dart';
import '../../../share/widgets/count_down.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_rate.dart';
import '../widget/booking/item_title.dart';

class ChargingPage extends StatefulWidget {
  const ChargingPage(
      {super.key,
      this.onTapFinish,
      required this.connector,
      this.station,
      this.onTapReview,
      });

  final Function()? onTapFinish;
  final List<Connector> connector;
  final Station? station;
  final Function()? onTapReview;


  @override
  State<ChargingPage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<ChargingPage> with SingleTickerProviderStateMixin{
  final WebSocketManager _wsManager = WebSocketManager();
  AnimationController? _animationController;
  int levelClock = 3 * 60;

  @override
  void initState() {
/*     WebSocketManager()
         .transmit(jsonEncode({
       "action": "StartTransaction",
       "messageId": "123",
       "payload": {
         "status": "Charging",
         "timestamp": "2025-03-27T22:07:09",
         "chargerId": "${widget.station?.externalId}",
         "energyConsumed": 0
       }
     }));*/
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
            connectorId: '# ${widget.connector[UtilsLocation.index.value].connectorId}',
            maxPower: '${widget.connector[UtilsLocation.index.value].maxPower} kBT',
          ),
          8.height,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemRate(
                title: 'Тариф',
                description:
                    '${widget.connector[UtilsLocation.index.value].costPerKwh?.toStringAsFixed(0)} sum / кВТ*ч',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Заряжено на:', style: context.textTheme.titleSmall),
                  Text('${widget.connector[UtilsLocation.index.value].energyConsumed} kBT',
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
              //const Expanded(child: ItemBattery()),
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
                      child:   Countdown(
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
                onTap: (){
/*                  WebSocketManager().transmit(jsonEncode({
                    "action": "StopTransaction",
                    "messageId": "1234",
                    "payload": {
                      "transactionId": "3ef22a69-49ca-49e7-aab7-b67c5bb2d49c",
                      "status": "Finishing",
                      "timestamp": "2025-03-27T22:07:09",
                      "chargerId": "STS_001",
                      "energyConsumed": 20,
                      "cost": 20.5
                    }
                  }));*/
                  UtilsLocation.setChargingUp =
                      BookingStation.finish;
                },
                child: CircleContainer(
                  color: AppColorsDark.bodyText,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text('${widget.connector[0].energyConsumed} sum / Завершить',
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
