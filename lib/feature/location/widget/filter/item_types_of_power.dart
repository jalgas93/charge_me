import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../utils/utils_location.dart';

class ItemTypesOfPower extends StatelessWidget {
  const ItemTypesOfPower({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мощности',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          26.height,
          SizedBox(
            height: context.screenSize.width / 10,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: list.length,
              // physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, final int index) {
                return GestureDetector(
                  onTap: () {
                    UtilsLocation.setOfPower = list[index];
                  },
                  child: ValueListenableBuilder(
                    valueListenable: UtilsLocation.typesOfPower,
                    builder: (context, value, child) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: value == list[index]
                                ? context.theme.focusColor
                                : AppColorsDark.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text('${list[index]} kBT',
                              style: context.textTheme.bodyLarge?.copyWith(
                                  color: value == list[index]
                                      ? context.theme.indicatorColor
                                      : context.textTheme.bodyLarge?.color)),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, int index) {
                return const SizedBox(width: 4);
              },
            ),
          ),
        ],
      ),
    );
  }
}
