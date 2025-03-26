import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification(
      {super.key,
      required this.title,
      required this.description,
      required this.time});

  final String title;
  final String description;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          Text(
            description,
            style: context.textTheme.bodyMedium,
            maxLines: 3,
          ),
          Text(time,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              )),
        ],
      ),
    );
  }
}
