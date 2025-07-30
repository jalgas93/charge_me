import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../bloc/websocket/websocket_bloc.dart';

class CancelActive extends StatefulWidget {
  const CancelActive({super.key, this.onActive, this.connectorId});

  final Function()? onActive;
  final String? connectorId;

  @override
  State<CancelActive> createState() => _CancelActiveState();
}

class _CancelActiveState extends State<CancelActive> {
  late WebsocketBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<WebsocketBloc>(context);
    super.initState();
  }

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
          Flexible(
            child: Text(
              '🔌 Моя очередь заряжаться!',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: AppColorsDark.darkStyleText),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: widget.onActive,
                child: Text(
                  'Отменить:',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: AppColorsDark.blue2),
                ),
              ),
              Text(
                '2 sek',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColorsDark.blue2),
              ),
            ],
          )
        ],
      ),
    );
  }
}
