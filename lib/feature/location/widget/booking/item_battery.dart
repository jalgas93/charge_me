import 'dart:ui';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../_app/widgets/circle_container.dart';

class ItemBattery extends StatelessWidget {
  const ItemBattery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 5,
      padding: const EdgeInsets.only(left: 60,right: 60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(25)),
      child: Container(
        padding: const EdgeInsets.all(16),
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
                mainAxisAlignment: MainAxisAlignment.center,
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
