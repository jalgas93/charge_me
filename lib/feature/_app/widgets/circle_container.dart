import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, this.child, this.color, this.padding, this.alignment});

  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding ?? const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: color ?? AppColorsDark.white,
          borderRadius: BorderRadius.circular(25)),
      child: child,
    );
  }
}
