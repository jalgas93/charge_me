import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/material.dart';

import '../../_app/widgets/circle_container.dart';
import '../model/stations.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    required this.title,
    required this.description,
    this.descriptionSupplement,
    required this.stationId,
    required this.connector,
    this.amperage,
    this.power,
  });

  final String title;
  final String description;
  final String? descriptionSupplement;
  final String stationId;
  final Connector? connector;
  final num? amperage;
  final int? power;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        8.height,
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (descriptionSupplement != null)
          Text(
            descriptionSupplement!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        8.height,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleContainer(
              child: Text(
                stationId,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColorsDark.darkStyleText),
              ),
            ),
            8.width,
            if(connector?.connectorId!=null)
            CircleContainer(
                child: Text(
              '${connector?.connectorId}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColorsDark.darkStyleText),
            )),
            8.width,
            if(connector?.maxPower!=null)
            CircleContainer(
              child: Text(
                '${connector?.maxPower} kW',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColorsDark.darkStyleText),
              ),
            ),
            8.width,
            if(amperage!=null)
            CircleContainer(
              child: Text(
                '$amperage A',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColorsDark.darkStyleText),
              ),
            ),
            8.width,
            if(power!=null)
            CircleContainer(
              child: Text(
                '$power kW',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColorsDark.darkStyleText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
