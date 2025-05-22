import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/auth/utils/auth_utils.dart';
import 'package:flutter/material.dart';

class SocialNetwork extends StatelessWidget {
  const SocialNetwork({super.key, required this.image, this.onTap, required this.isSelected});

  final String image;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image))),
          ),
        ),
        16.height,
        isSelected ? Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
              color: context.theme.focusColor,
              shape: BoxShape.circle),
        ):const SizedBox.shrink()
      ],
    );
  }
}
