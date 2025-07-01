import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../share/widgets/custom_button.dart';
import '../../../core/provider/websocket_provider.dart';
import '../model/stations.dart';
import '../utils/utils_location.dart';
import '../widget/booking/item_battery.dart';
import '../widget/booking/item_title.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    this.station,
    this.onTap,
    this.stopTransaction,
  });

  final Station? station;
  final dynamic Function()? onTap;
  final Transaction? stopTransaction;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Connector>? get connector =>
      Provider.of<ConnectorProviderData>(context).connector;

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
                '# ${connector?[UtilsLocation.index.value].connectorId}',
            maxPower:
                '${connector?[UtilsLocation.index.value].maxPower} kBT',
          ),
          const Divider(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Номер транзакции'),
                  16.width,
                  Flexible(child: Text('${widget.stopTransaction?.transactionId}')),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Начало зарядки'),
                  Text(DateFormat('dd.MM.yyyy HH:mm').format(widget.stopTransaction!.startTime!)),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Окончание зарядки'),
                  Text(DateFormat('dd.MM.yyyy HH:mm').format(widget.stopTransaction!.endTime!)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Тариф'),
                  Text("${widget.stopTransaction?.costPerKwh?.toStringAsFixed(0)} Sum"),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Итого'),
                  Text("${widget.stopTransaction?.cost?.toStringAsFixed(0)} Sum"),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Общее потребление'),
                  Text('${widget.stopTransaction?.energyConsumed}'),
                ],
              ),
            ],
          ),
          const Divider(),
          16.height,
          CustomButton(
              onTap: widget.onTap ??
                  () {
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
