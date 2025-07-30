import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../_app/widgets/throw_error.dart';
import 'item_connector.dart';
import 'item_types_of_power.dart';

class Filters extends StatelessWidget {
  const Filters({super.key, required this.list, required this.list2});

  final List<String> list;
  final List<int> list2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSize.height/2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Фильтры',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: AppColorsDark.black, shape: BoxShape.circle),
                      child: Text('5', style: context.textTheme.bodyMedium),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ThrowError.showNotify(
                        context: context, errMessage: 'Еще не реализовано');
                  },
                  child: Text(
                    'Очистить',
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
         // ItemConnector(list: list),
          const Divider(),
          ItemTypesOfPower(list: list2),
          16.height
        ],
      ),
    );
  }
}
