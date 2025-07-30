import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/router.gr.dart';
import '../../../account/widget/title_fields.dart';
import '../custom_button.dart';


class SuccessStatus extends StatelessWidget {
  const SuccessStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/success.png'),
        const TitleFields(
          field: 'Successful',
          field2: ' create',
          field3: '',
        ),
        Text('Lorem ipsum dolor sit amet, consectetur.',
            style: context.textTheme.bodyMedium),
        16.height,
        CustomButton(
            width: context.screenSize.width,
            onTap: () async {
              context.router.pushAndPopUntil(
                  const DashboardPageRoute(),
                  predicate: (Route<dynamic> route) => false);
            },
            text: 'Завершить')
      ],
    );
  }
}
