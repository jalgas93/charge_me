import 'package:flutter/material.dart';

class ChargeBottomSheet{
  static Future<void> draggableScrollableSheet({
    required BuildContext context,
    required List<Widget> children,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // You can wrap this Column with Padding of 8.0 for better design
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        );
      },
    );
  }
}