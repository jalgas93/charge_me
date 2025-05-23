import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class ConnectorSelection extends StatelessWidget {
  const ConnectorSelection(
      {super.key,
      required this.constraints,
      this.onTap,
      required this.image,
      required this.numbering,
      required this.title,
      required this.isSelected});

  final BoxConstraints constraints;
  final Function()? onTap;
  final String image;
  final String numbering;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.focusColor
              : AppColorsDark.whiteSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  color: isSelected
                      ? AppColorsDark.white
                      : AppColorsDark.primaryContainer,
                ),
              ),
            ),
            Positioned(
                top: 10,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColorsDark.lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    numbering,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(title,
                      style: context.textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? AppColorsDark.white
                              : AppColorsDark.darkStyleText))),
            ),
          ],
        ),
      ),
    );
  }
}
