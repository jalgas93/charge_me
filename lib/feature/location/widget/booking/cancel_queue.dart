import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';

class CancelQueue extends StatefulWidget {
  const CancelQueue({
    super.key,
    this.position,
    this.onQueue,
  });

  final int? position;
  final Function()? onQueue;

  @override
  State<CancelQueue> createState() => _CancelQueueState();
}

class _CancelQueueState extends State<CancelQueue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: const BoxDecoration(
          color: AppColorsDark.secondaryColorW,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ваш очередь: ${widget.position}',
            style: context.textTheme.bodyLarge
                ?.copyWith(color: AppColorsDark.darkStyleText),
          ),
          TextButton(
            onPressed: widget.onQueue,
            child: Text(
              'Отменить очередь',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: AppColorsDark.blue2),
            ),
          )
        ],
      ),
    );
  }
}
