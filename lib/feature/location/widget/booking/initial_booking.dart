import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/location/model/stations.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';
import '../../../../share/widgets/custom_button.dart';
import 'item_title.dart';

class InitialBooking extends StatelessWidget {
  const InitialBooking(
      {super.key, required this.station, required this.stream});

  final Station station;
  final Stream stream;

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
                id: '${station.externalId}',
              ),
              8.height,
              const Divider(),
              8.height,
              Text(
                'Типы зарядных устройств',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.height,
              StreamBuilder(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    var connector =
                        ConnectorList.fromJson(snapshot.data).payload;
                    print("object ${connector}");
                    if (connector != null) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxWidth / 3,
                        child: ListView.separated(
                          itemCount: connector.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () {
                                UtilsLocation.setConnector =
                                    connector[index].type;
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${connector[index].type}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        8.width,
                                        Text(
                                          '${connector[index].status}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: connector[index]
                                                              .status ==
                                                          'AVAILABLE'
                                                      ? AppColorsDark.yellow1
                                                      : AppColorsDark.red1),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${connector[index].maxPower} kBT',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: value ==
                                                            connector[index]
                                                                .type
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
                                                    color: value ==
                                                            connector[index]
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
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              8.height,
              const Divider(),
              8.height,
              CustomButton(
                  onTap: () {
                    UtilsLocation.setChargingUp = BookingStation.successBooking;
                  },
                  radius: 25,
                  text: 'Продолжить'),
            ],
          );
        },
      ),
    );
  }
}
