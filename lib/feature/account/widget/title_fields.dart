import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class TitleFields extends StatelessWidget {
  const TitleFields({super.key, required this.field, required this.field2, required this.field3});

  final String field;
  final String field2;
  final String field3;

  @override
  Widget build(BuildContext context) {
    return RichText(
      // Controls visual overflow
      overflow: TextOverflow.clip,
      // Controls how the text should be aligned horizontally
      textAlign: TextAlign.start,
      // Control the text direction
      textDirection: TextDirection.ltr,
      // Whether the text should break at soft line breaks
      softWrap: true,
      // Maximum number of lines for the text to span
      textScaler: const TextScaler.linear(1),
      maxLines: 2,
      text: TextSpan(
        text: field,
        style: context.textTheme.bodyLarge
            ?.copyWith(fontSize: 22),
        children: <TextSpan>[
          TextSpan(
            text: field2,
            style: context.textTheme.titleLarge?.copyWith(color: AppColorsDark.primaryContainer),
          ),
          TextSpan(
            text: field3,
            style: context.textTheme.bodyLarge?.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
