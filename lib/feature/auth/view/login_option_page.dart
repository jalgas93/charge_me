import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';

import '../../../share/widgets/custom_button.dart';

@RoutePage(name: "LoginOptionRoutePage")
class LoginOptionPage extends StatefulWidget {
  const LoginOptionPage({super.key});

  @override
  State<LoginOptionPage> createState() => _LoginOptionPageState();
}

class _LoginOptionPageState extends State<LoginOptionPage> {
  var imageList = [
    'assets/Image.png',
    'assets/car_2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: constraints.maxWidth / 1.2,
                  child: Image.asset(
                    'assets/Image.png',
                    fit: BoxFit.contain,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text('Wellcome!',
                      style: context.textTheme.headlineLarge)),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                    width: constraints.maxWidth / 1.2,
                    onTap: () {
                      context.router.push(const SignInFormRoutePage());
                    },
                    text: 'Continue with Email'),
              ),
            ],
          );
        },
      ),
    );
  }
}
