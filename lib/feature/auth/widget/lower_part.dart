import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../view/register_form_page.dart';


class LowerPart extends StatelessWidget {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Divider(color: context.theme.dividerColor),
            const Text('OR'),
            Divider(color: context.theme.dividerColor),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: context.screenSize.width / 5,
              width: context.screenSize.width / 2.5,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: context.theme.cardTheme.color,
                  image: const DecorationImage(
                      image: AssetImage('assets/google.png'))),
              child: Image.asset('assets/google.png'),
            ),
            Container(
              height: context.screenSize.width / 5,
              width: context.screenSize.width / 2.5,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: context.theme.cardTheme.color,
                  image: const DecorationImage(
                      image: AssetImage('assets/facebook.png'))),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don’t have an account?', style: context.textTheme.bodyLarge),
            TextButton(
                onPressed: () {
                 // context.router.push(const RegisterFormPage());
                },
                child: Text('Register', style: context.textTheme.titleSmall))
          ],
        ),
      ],
    );
  }
}
