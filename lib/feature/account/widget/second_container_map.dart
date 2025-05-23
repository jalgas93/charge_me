import 'dart:ui';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/item_app_bar.dart';

class SecondContainerMap extends StatelessWidget {
  const SecondContainerMap(
      {super.key,
      this.onTap,
      required this.constraints,
      required this.isLocation});

  final Function()? onTap;
  final BoxConstraints constraints;
  final bool isLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        16.height,
        Stack(
          children: [
            Container(
              height: constraints.maxHeight / 1.8,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  image: DecorationImage(
                      image: AssetImage("assets/map_image.png"),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: GestureDetector(
                      onTap:onTap ,
                      child: Text('Выберите на карте',
                          style: context.textTheme.bodyLarge
                              ?.copyWith(color: AppColorsDark.darkStyleText)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        16.height,
        isLocation
            ? Row(
                children: [
                  const ItemAppBar(
                    color: AppColorsDark.whiteSecondary,
                    icon: 'assets/icon_pin.png',
                  ),
                  16.width,
                  Flexible(
                    child: Text(
                      'Jl. Cisangkuy, Citarum, Kec. Bandung Wetan, Kota Bandung, Jawa Barat 40115',
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
