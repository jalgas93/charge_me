import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';

class ItemFilter extends StatelessWidget {
  const ItemFilter(
      {super.key,
      required this.image,
      required this.title,
      required this.isSelected});

  final String image;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF234F68) : const Color(0xffF5F4F8),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: 8,
          ),
          child: Row(
            children: [
              Image.asset(image),
              8.width,
              Text(title,
                  style: context.textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? context.theme.indicatorColor
                          : AppColorsDark.darkStyleText)),
            ],
          ),
        ),
      ),
    );
  }
}
