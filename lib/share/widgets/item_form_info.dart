import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';
import '../../feature/account/widget/title_fields.dart';
import 'custom_button.dart';

class ItemFormInfo extends StatelessWidget {
  const ItemFormInfo({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: context.screenSize.width / 2,
            top: context.screenSize.width / 2,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: context.theme.cardTheme.color,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/success.png'),
                const TitleFields(
                  field: 'Successful',
                  field2: ' ',
                  field3: 'create',
                ),
                Text('Lorem ipsum dolor sit amet, consectetur.',
                    style: context.textTheme.bodyMedium),
                16.height,
                CustomButton(
                    width: context.screenSize.width / 1.8,
                    onTap: () async {
                      context.router.pushAndPopUntil(const DashboardPageRoute(),
                          predicate: (Route<dynamic> route) => false);
                    },
                    text: 'Завершить'),
                16.height,
              ],
            ),
          )),
    );
  }
}
