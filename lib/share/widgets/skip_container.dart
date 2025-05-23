import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../core/styles/app_colors_dark.dart';

class SkipContainer extends StatelessWidget {
  const SkipContainer({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: AppColorsDark.black,
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          "Пропустить",
          style: context.textTheme.bodyLarge
              ?.copyWith(color: AppColorsDark.whiteSecondary),
        ),
      ),
    );
  }
}
