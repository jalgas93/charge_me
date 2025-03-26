import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/circle_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../dashboard/utils/utils_dashboard.dart';

class Station extends StatelessWidget {
  const Station({super.key, required this.listConnectors});

  final List<String> listConnectors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'СИТИ ЦЕНТР ТЦ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.height,
              Text(
                'Улица Мирзо Улугбекаб Ташкент',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Время работы с 00:00 - 24:00',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              8.height,
              CircleContainer(
                child: Text(
                  'ID 81862612',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Типы зарядных устройств',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.height,
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth / 3,
                child: ListView.separated(
                  itemCount: listConnectors.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        UtilsLocation.setConnector = listConnectors[index];
                      },
                      child: ValueListenableBuilder(
                        valueListenable: UtilsLocation.typesConnector,
                        builder: (context, value, child) {
                          return Container(
                            height: constraints.maxWidth / 3,
                            width: constraints.maxWidth / 2.5,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: value == listConnectors[index]
                                    ? context.theme.focusColor
                                    : AppColorsDark.black,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listConnectors[index],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '60 kBT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color:
                                                value == listConnectors[index]
                                                    ? AppColorsDark.white
                                                    : AppColorsDark.green1,
                                          ),
                                    ),
                                    Text(
                                      r'14$ / кВТ*ч ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color:
                                                value == listConnectors[index]
                                                    ? AppColorsDark.white
                                                    : AppColorsDark.white,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const SizedBox(width: 8);
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              CustomButton(onTap: () {
                UtilsDashboard.setChange = true;
              }, radius: 25, text: 'Забронировать'),
            ],
          );
        },
      ),
    );
  }
}
