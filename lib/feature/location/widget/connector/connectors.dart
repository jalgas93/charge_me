import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:charge_me/feature/location/utils/helper_charging.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/app_colors_dark.dart';
import '../color_file.dart';

class ConnectorPage extends StatefulWidget {
  const ConnectorPage({
    super.key,
    required this.connector,
    required this.text,
  });

  final Connector connector;
  final text;

  @override
  State<ConnectorPage> createState() => _ConnectorPageState();
}

class _ConnectorPageState extends State<ConnectorPage> {
  Connector get connector => widget.connector;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 16,bottom: 16),
      decoration: BoxDecoration(
          color: connector.type == widget.text
              ? AppColorsDark.green1
              : AppColorsDark.black,
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Charging().connectorType(type: connector.type!),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          8.width,
          Text(
            '${connector.status?.toUpperCase()}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorFile().statusColor(
                    status: connector.status?.toUpperCase() ?? '')),
          ),
          if (connector.status?.toLowerCase() == "booking")
            Text(Charging().maskNumber(connector.blockedBy),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: connector.type == widget.text
                    ? AppColorsDark.white
                    : AppColorsDark.yellow1,
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${connector.maxPower} kW',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: connector.type == widget.text
                      ? AppColorsDark.white
                      : AppColorsDark.green1,
                ),
              ),
              Text(
                '${connector.costPerKwh?.toStringAsFixed(0)} Sum / kWh',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: connector.type == widget.text
                      ? AppColorsDark.white
                      : AppColorsDark.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
