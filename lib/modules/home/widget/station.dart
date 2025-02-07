import 'package:charge_me/modules/app_common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../app_common/widget/custom_button.dart';
import '../../dashboard/utils/utils_dashboard.dart';

class Station extends StatelessWidget {
  const Station({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Станция 2',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Улица Мирзо Улугбекаб Ташкент',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color(0xff8E8E93)),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              UtilsDashboard.setChange = true;
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'A порт',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 6,
                          bottom: 6,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xff0073FF).withOpacity(0.15),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          'Свободен',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: const Color(0xff0073FF)),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'B порт',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 6,
                          bottom: 6,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xff0073FF).withOpacity(0.15),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Text(
                          'Свободен',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: const Color(0xff0073FF)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: context.screenSize.width / 3),
          CustomButton(
              color: const Color(0xffF1F1F1),
              onTap: () {},
              radius: 12,
              text: 'Выберите порт из списка'),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: context.screenSize.width / 3,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
            ),
          ),
        ],
      ),
    );
  }
}
