import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import 'item_icon_container.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer(
      {super.key,
      required this.title,
      this.description,
      required this.image,
      this.colorText,
      this.colorIcon,
      this.onTap,
      });

  final String title;
  final String? description;
  final String image;
  final Color? colorText;
  final Color? colorIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 2, bottom: 2),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColorsDark.white3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ItemIconContainer(
                  child: Image.asset(image, color: colorIcon),
                ),
                16.width,
                Text(title,
                    style:
                        context.textTheme.titleSmall?.copyWith(color: colorText)),
              ],
            ),
            if (description != null) ...[
              Text(description!, style: context.textTheme.titleSmall)
            ] else ...[
              const Icon(
                Icons.chevron_right,
                color: AppColorsDark.white,
              )
            ]
          ],
        ),
      ),
    );
  }
}
