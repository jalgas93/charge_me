import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/router.gr.dart';
import '../../widgets/custom_button.dart';

@RoutePage(name: "StatusPageRoute")
class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            16.height,
            Image.asset('assets/success.png'),
            Text('Success', style: context.textTheme.titleLarge),
            Text('Lorem ipsum dolor sit amet, consectetur.',
                style: context.textTheme.bodyMedium),
            Spacer(),
            CustomButton(
                width: context.screenSize.width,
                onTap: () async {
                  context.router.pushAndPopUntil(
                      const DashboardPageRoute(),
                      predicate: (Route<dynamic> route) => false);
                },
                text: 'На главный экран')
          ],
        ),
      ),
    );
  }
}
