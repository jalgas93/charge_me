import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';

class ItemAppBar extends StatelessWidget {
  const ItemAppBar(
      {super.key,
      required this.icon,
      this.onPressed,
      this.color,
      this.colorIcon,
      this.colorBorder,
      this.isIcon = false});

  final String icon;
  final void Function()? onPressed;
  final Color? color;
  final Color? colorIcon;
  final Color? colorBorder;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorBorder ?? AppColorsDark.green2),
          color: color ?? AppColorsDark.black),
      child: isIcon
          ? Image.asset(icon)
          : IconButton(
              onPressed: onPressed,
              icon: Image.asset(icon, color: colorIcon),
            ),
    );
  }
}
