import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors_dark.dart';


class CarStatus extends StatelessWidget {
  const CarStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: constraints.maxWidth/2,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF182724),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Battery', style: context.textTheme.bodyMedium),
                  4.height,
                  Container(
                  padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                       // border: Border.all(color: AppColorsDark.greyBorder),
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF03DABB), Color(0xFF03DA99)],
                        )),
                    child: const SizedBox(
                        height: 70,
                    width: 45,
                    ),
                  ),
                  2.height,
                  Text('Battery', style: context.textTheme.bodyMedium),
                  2.height,
                  Text('Find Station',
                      style: context.textTheme.bodyMedium)
                ],
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF182724),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Batterydfsfsdf', style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                  4.height,
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF182724),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Batterysdfsf', style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
