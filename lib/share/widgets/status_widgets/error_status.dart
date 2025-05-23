import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../feature/account/widget/title_fields.dart';
import '../custom_button.dart';

class ErrorStatus extends StatelessWidget {
  const ErrorStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/success.png'),
        const TitleFields(
          field: 'Your listing is now',
          field2: ' published',
          field3: '',
        ),
        Text('Lorem ipsum dolor sit amet, consectetur.',
            style: context.textTheme.bodyMedium),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                width: context.screenSize.width / 2.8,
                onTap: () async {},
                text: 'Close'),
            CustomButton(
                width: context.screenSize.width / 2.8,
                onTap: () async {},
                text: 'Finish')
          ],
        )
      ],
    );
  }
}
