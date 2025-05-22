import 'dart:ui';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/item_app_bar.dart';


class SecondContainerMap extends StatelessWidget {
  const SecondContainerMap({super.key, this.onPressed, required this.constraints});

  final Function()? onPressed;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        16.height,
        Container(
          height: constraints.maxWidth,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              )),
        ),
        ClipRRect(
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
              child: TextButton(
                onPressed: onPressed,
                child: Text('Select on the map',
                    style: context.textTheme.bodyLarge),
              ),
            ),
          ),
        )
      ],
    );
  }
}
