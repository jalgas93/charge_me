import 'dart:ui';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/circle_container.dart';

class ItemBattery extends StatelessWidget {
  const ItemBattery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(100)),
      child: SizedBox(
        height: context.screenSize.width / 9,
        width: context.screenSize.width / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CircleContainer(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Row(
                children: [
                  Image.asset('assets/lightning.png',
                      color: AppColorsDark.green1),
                  Text('57 %',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColorsDark.green3,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
