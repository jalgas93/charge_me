import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/item_app_bar.dart';


class AddressInfo extends StatefulWidget {
  const AddressInfo({super.key});

  @override
  State<AddressInfo> createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.width / 2.5,
      width: context.screenSize.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColorsDark.white,
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Информация о местоположении',
              style: context.textTheme.titleSmall
                  ?.copyWith(color: AppColorsDark.darkStyleText)),
          16.height,
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
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColorsDark.darkStyleText),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
