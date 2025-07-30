import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../location/bloc/websocket/websocket_bloc.dart';


class ChargeBottomSheet {
  static Future<dynamic> draggableScrollableSheet({
    required BuildContext context,
    required List<Widget> children,
  }) async {
    final myBloc = BlocProvider.of<WebsocketBloc>(context);
    return await showModalBottomSheet(
      context: context,
      useSafeArea: true,
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

  static Future<dynamic> showInMap({
    required BuildContext context,
    double? latitude,
    double? longitude,
    required List<AvailableMap> availableMaps,
  }) async {
    return await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (context) {
          if (availableMaps.isEmpty) {
            return const Center(
              child: Text(''),
            );
          }
          return ItemDraggable(children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  for (var map in availableMaps) ...[
                    GestureDetector(
                      onTap: () {
                        if (latitude != null && longitude != null) {
                          map.showDirections(
                              destination: Coords(latitude, longitude));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  map.icon,
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 8.0),
                                Text(map.mapName),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            )
          ]);
        });
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
