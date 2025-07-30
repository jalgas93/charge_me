import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/app_user.dart';
import '../../_app/widgets/custom_button.dart';
import '../../auth/widget/title_text.dart';
import '../bloc/websocket/websocket_bloc.dart';
import '../model/stations.dart';
import '../widget/finish/calculate_result.dart';
import '../widget/finish/result_container.dart';
import '../widget/item_title.dart';

@RoutePage(name: 'FinishRoutePage')
class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    this.station,
    this.connector,
    this.stopTransaction,
  });

  final Station? station;
  final Connector? connector;
  final Transaction? stopTransaction;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Connector? get connector => widget.connector;

  Station? get station => widget.station;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var websocketBloc = context.read<WebsocketBloc>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Результат'.toUpperCase()),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
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
            ResultContainer(
                title: "Номер транзакции",
                description: '${widget.stopTransaction?.transactionId}'),
            ResultContainer(
              title: "Начало зарядки",
              description: DateFormat('dd.MM.yyyy HH:mm')
                  .format(widget.stopTransaction!.startTime!),
            ),
            ResultContainer(
              title: "Окончание зарядки",
              description: DateFormat('dd.MM.yyyy HH:mm')
                  .format(widget.stopTransaction!.endTime!),
            ),
            ResultContainer(
              title: "Продолжительность",
              description: widget.stopTransaction!.duration!,
            ),
            ResultContainer(
              title: "Тариф",
              description:
                  "${widget.stopTransaction?.costPerKwh?.toStringAsFixed(0)} тенге",
            ),
            ResultContainer(
              title: "Время бронирование",
              description: "${widget.stopTransaction?.bookingTime}",
            ),
            ResultContainer(
              title: "Сумма бронирование",
              description:
                  "${widget.stopTransaction?.bookingCost?.toStringAsFixed(0)} тенге",
            ),
            ResultContainer(
                title: "Общее потребление",
                description:
                    '${widget.stopTransaction?.energyConsumed?.toStringAsFixed(0)} kW'),
            ResultContainer(
              title: "Итого",
              description:
                  "${CalculateResult().result(
                      cost: widget.stopTransaction?.energyConsumed,
                      bookingCost: widget.stopTransaction?.bookingCost,
                      tariff: widget.stopTransaction?.costPerKwh)?.toStringAsFixed(0)} тенге",
            ),
            16.height,
            CustomButton(
                onTap: () {
                  websocketBloc.add(WebsocketEvent.check(
                    message: jsonEncode({
                      "action": "Check",
                      "messageId": "check",
                      "payload": {
                        "message": "finish",
                        "userId": AppUser.userModel?.userId,
                        "connectorId": "${connector?.connectorId}"
                      }
                    }),
                  ));
                  context.router.push(const DashboardPageRoute());
                  context.router.pushAndPopUntil(
                      const DashboardPageRoute(),
                      predicate: (Route<dynamic> route) => false);
                },
                radius: 25,
                text: 'Завершить'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
