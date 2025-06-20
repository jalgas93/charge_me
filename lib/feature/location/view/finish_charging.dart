import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../share/widgets/custom_button.dart';
import '../../../core/logging/log.dart';
import '../../../core/network/http/websocket_client.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_battery.dart';
import '../widget/booking/item_title.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.connector,
    this.station,
  });

  final List<Connector> connector;
  final Station? station;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final WebSocketManager _wsManager = WebSocketManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const ItemBattery(),
          8.height,
          const Divider(),
          ItemTitle(
            title: widget.station?.location?.city ?? '',
            description: widget.station?.location?.address ?? '',
            stationId: widget.station?.externalId ?? '',
            connectorId:
                '# ${widget.connector[UtilsLocation.index.value].connectorId}',
            maxPower:
                '${widget.connector[UtilsLocation.index.value].maxPower} kBT',
          ),
          const Divider(),
          StreamBuilder(
            stream: _wsManager.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Waiting for the stream
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}"); // Show error message
              } else if (snapshot.hasData) {
                Log.i("snapshot data ${snapshot.data}");
                if (ConnectorList.fromJson(snapshot.data).action ==
                    'StartTransaction') {
                  var transaction = Transaction.fromJson(snapshot.data);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Номер сессис'),
                          Text('${transaction.transactionId}'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Общее потребление'),
                          Text('${transaction.energyConsumed}'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Начало зарядки'),
                          Text('${transaction.startTime}'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Окончание зарядки'),
                          Text('${transaction.endTime}'),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Продолжительность'),
                          Text('12:40'),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Тариф'),
                          Text('12'),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Итого'),
                          Text('50'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Общее потребление'),
                          Text('${transaction.energyConsumed}'),
                        ],
                      ),
                    ],
                  );
                }
              } else {
                return const Text(
                    "No data available"); // Handle any other cases
              }
              return const SizedBox.shrink();
            },
          ),
          const Divider(),
          16.height,
          CustomButton(
              onTap: () {
                UtilsLocation.setChargingUp = BookingStation.connect;
                context.router.popForced();
              },
              radius: 25,
              text: 'Завершить'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
