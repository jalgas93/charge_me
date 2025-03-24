import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/styles/app_colors.dart';
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
            colors: [
              AppColors.secondaryColor1,
              AppColors.secondaryColor3,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 10),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black12,
          )
        ],
      ),
      child: isLoading ?? false
          ? Center(
              child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).indicatorColor,
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
