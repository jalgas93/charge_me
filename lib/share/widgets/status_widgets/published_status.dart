import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../feature/account/widget/title_fields.dart';
import '../custom_button.dart';


class PublishedStatus extends StatelessWidget {
  const PublishedStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/danger_2.png',
        ),
        const Align(
          alignment: Alignment.center,
          child: TitleFields(
            field: 'Aw snap, Something',
            field2: '  error',
            field3: ' happened',
          ),
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
                text: 'Add More'),
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
