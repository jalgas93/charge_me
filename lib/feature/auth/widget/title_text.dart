import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {super.key,
      required this.title,
      required this.supplementary,
      required this.description});

  final String title;
  final String supplementary;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: context.textTheme.titleLarge),
              const SizedBox(width: 8),
              Text(supplementary, style: context.textTheme.headlineMedium),
            ],
          ),
          Text(description, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
