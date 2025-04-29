import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../share/widgets/circle_container.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle(
      {super.key,
      required this.title,
      required this.description,
        this.descriptionSupplement,
      required this.id,
      this.number,
      this.watt});

  final String title;
  final String description;
  final String? descriptionSupplement;
  final String id;
  final String? number;
  final String? watt;

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
                id,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            8.width,
            if (number != null)
              CircleContainer(
                child: Text(
                  number!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            8.width,
            if (number != null)
              CircleContainer(
                child: Text(
                  watt!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        )
      ],
    );
  }
}
