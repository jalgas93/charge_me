import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../_app/widgets/circle_container.dart';
import '../../utils/utils_location.dart';

class ButtonBooking extends StatelessWidget {
  const ButtonBooking({
    super.key,
    this.onTap,
    required this.name,
    required this.containerColor,
    required this.nameColor,
  });

  final Function()? onTap;
  final String name;
  final Color containerColor;
  final Color nameColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CircleContainer(
          color: containerColor,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(name,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: nameColor,
              )),
        ),
      ),
    );
  }
}
