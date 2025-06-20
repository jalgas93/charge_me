import 'dart:ffi';

import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/styles/app_colors_dark.dart';
import '../../feature/location/bloc/websocket/websocket_bloc.dart';

class ChargeBottomSheet {
  static Future<dynamic> draggableScrollableSheet({
    required BuildContext context,
    required List<Widget> children,
  }) async {
    final myBloc = BlocProvider.of<WebsocketBloc>(context);
    return await showModalBottomSheet(
      context: context,
      useSafeArea: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: myBloc,
          child: ItemDraggable(children: children),
        );
      },
    );
  }
}

class ItemDraggable extends StatelessWidget {
  const ItemDraggable({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Container(
            height: 5,
            width: context.screenSize.width / 6,
            decoration: BoxDecoration(
                color: AppColorsDark.white1,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // You can wrap this Column with Padding of 8.0 for better design
          child: Column(children: children),
        )
      ],
    );
  }
}
