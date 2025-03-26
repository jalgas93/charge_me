import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? radius;
  final double? height;
  final double? width;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.radius,
    this.height,
    this.width,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width ?? context.screenSize.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColorsDark.gradientGreen,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 10),
        ),
      ),
      child: isLoading ?? false
          ? const Center(
              child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: AppColorsDark.white,
                  )))
          : TextButton(
              onPressed: onTap,
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
    );
  }
}
