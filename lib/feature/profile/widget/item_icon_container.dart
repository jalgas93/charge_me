import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class ItemIconContainer extends StatelessWidget {
  const ItemIconContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColorsDark.white),
      child: child,
    );
  }
}
