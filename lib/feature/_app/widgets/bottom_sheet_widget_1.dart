import 'package:flutter/material.dart';


class BottomSheetWidgetOne extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String text;
  final double? height;
  final double? width;
  final Color? color;


  const BottomSheetWidgetOne({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    this.color,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.width / 6,
        width: width ?? MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
