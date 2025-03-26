import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList(
      {super.key, required this.child, this.height, required this.itemCount});

  final Widget? child;
  final double? height;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            height: height ?? context.screenSize.width / 3,
            decoration: BoxDecoration(
                color: context.theme.canvasColor,
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
