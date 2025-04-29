import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../share/widgets/custom_button.dart';
import '../../utils/utils_location.dart';
import 'item_battery.dart';
import 'item_title.dart';

class FinishCharging extends StatelessWidget {
  const FinishCharging({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      {
        'title': 'Номер сессис',
        'result': '716628',
      },
      {
        'title': 'Общее потребление',
        'result': '3.5 кВТ/ч',
      },
      {
        'title': 'Начало зарядки',
        'result': '17.08.23, 15:05',
      },
      {
        'title': 'Окончание зарядки',
        'result': '17.08.23, 25:00',
      },
      {
        'title': 'Продолжительность',
        'result': '12:58',
      },
      {
        'title': 'Тариф',
        'result': r'14$ / кВТ*ч',
      },
      {
        'title': 'Итого',
        'result': r'50,5$',
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const ItemBattery(),
          8.height,
          const Divider(),
          const ItemTitle(
            title: 'СИТИ ЦЕНТР ТЦ',
            description: 'Улица Мирзо Улугбекаб Ташкент',
            id: 'ID 81862612',
            number: '# U71509',
            watt: '60 kBT',
          ),
          const Divider(),
          SizedBox(
            height: context.screenSize.width / 1.5,
            child: ListView.separated(
              itemCount: list.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, final index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${list[index]['title']}'),
                    Text('${list[index]['result']}'),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
          const Divider(),
          16.height,
          CustomButton(
              onTap: () {
                UtilsLocation.setChargingUp = BookingStation.initialBooking;
                context.router.popForced();
              },
              radius: 25,
              text: 'Завершить'),
        ],
      ),
    );
  }
}
