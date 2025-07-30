import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../_app/widgets/item_app_bar.dart';

class ItemRate extends StatelessWidget {
  const ItemRate({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ItemAppBar(
          icon: 'assets/battery_charging.png',
          color: AppColorsDark.white,
          colorIcon: AppColorsDark.green3,
          colorBorder: AppColorsDark.green0,
        ),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.titleSmall),
            Text(description, style: context.textTheme.bodyMedium)
          ],
        )
      ],
    );
  }
}
