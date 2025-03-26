import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/share/widgets/throw_error.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import 'item_connector.dart';
import 'item_types_of_power.dart';

class Filters extends StatelessWidget {
  const Filters({super.key, required this.list, required this.list2});

  final List<String> list;
  final List<int> list2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Фильтры',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  8.width,
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            'Тип коннектора',
            style: context.textTheme.titleMedium,
          ),
          16.height,
          ItemConnector(list: list),
          16.height,
          const Divider(),
          Text(
            'Мощности',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          16.height,
          ItemTypesOfPower(list: list2),
          16.height,
        ],
      ),
    );
  }
}
