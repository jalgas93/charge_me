import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/custom_button.dart';
import '../widget/booking/item_title.dart';

class InitialPage extends StatelessWidget {
  const InitialPage(
      {super.key, required this.connector, this.onTap, required this.station});

  final Station station;
  final List<Connector> connector;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemTitle(
                title: '${station.location?.city}',
                description: '${station.location?.address}',
                descriptionSupplement: 'Время работы с 00:00 - 24:00',
                stationId: '${station.externalId}',
              ),
              8.height,
              const Divider(),
              8.height,
              Text(
                'Типы зарядных устройств',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.height,
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth / 3,
                child: ListView.separated(
                  itemCount: connector.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    print('index $index');
                    return GestureDetector(
                      onTap: () {
                        UtilsLocation.setConnector = connector[index].type;
                        UtilsLocation.setIndex = index;
                      },
                      child: ValueListenableBuilder(
                        valueListenable: UtilsLocation.typesConnector,
                        builder: (context, value, child) {
                          return Container(
                            height: constraints.maxWidth / 3,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                                color: value == connector[index].type
                                    ? context.theme.focusColor
                                    : AppColorsDark.black,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${connector[index].type}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                8.width,
                                Text(
                                  '${connector[index].status}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: connector[index].status ==
                                                  'AVAILABLE'
                                              ? AppColorsDark.yellow1
                                              : AppColorsDark.red1),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${connector[index].maxPower} kBT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color:
                                                value == connector[index].type
                                                    ? AppColorsDark.white
                                                    : AppColorsDark.green1,
                                          ),
                                    ),
                                    Text(
                                      '${connector[index].costPerKwh?.toStringAsFixed(0)} Sum / кВТ*ч',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: value == connector[index]
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
              8.height,
              const Divider(),
              8.height,
              CustomButton(onTap: onTap, radius: 25, text: 'Продолжить'),
            ],
          );
        },
      ),
    );
  }
}
