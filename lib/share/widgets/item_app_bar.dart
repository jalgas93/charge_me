import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors.dart';

class ItemAppBar extends StatelessWidget {
  const ItemAppBar(
      {super.key,
      required this.icon,
      this.onPressed,
      this.color,
      this.isShadow = false});

  final String icon;
  final void Function()? onPressed;
  final Color? color;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 7,
      width: context.screenSize.width / 7,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: AppColors.lightGreen.withOpacity(0.3),
                    offset: const Offset(0, 0),
                    blurRadius: 12,
                    spreadRadius: 16,
                  ),
                ]
              : [],
          color: color ?? AppColors.secondaryColor),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(icon),
      ),
    );
  }
}
