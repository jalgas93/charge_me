import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../share/widgets/circle_container.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle(
      {super.key,
      required this.title,
      required this.description,
      this.descriptionSupplement,
      this.type,
      required this.stationId,
      this.connectorId,
      this.maxPower});

  final String title;
  final String description;
  final String? descriptionSupplement;
  final String? type;
  final String stationId;
  final String? connectorId;
  final String? maxPower;

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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            8.width,
            if (connectorId != null)
              CircleContainer(
                child: Text(
                  connectorId!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            8.width,
            if (maxPower != null)
              CircleContainer(
                child: Text(
                  maxPower!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        )
      ],
    );
  }
}
