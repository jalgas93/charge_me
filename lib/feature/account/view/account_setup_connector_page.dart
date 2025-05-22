import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../widget/top_location.dart';

@RoutePage(name: "AccountSetupConnectorRoutePage")
class AccountSetupConnectorPage extends StatefulWidget {
  const AccountSetupConnectorPage({super.key});

  @override
  State<AccountSetupConnectorPage> createState() => _AccountSetupConnectorPageState();
}

class _AccountSetupConnectorPageState extends State<AccountSetupConnectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: AppColorsDark.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Выбор разъёма', style: context.textTheme.headlineMedium),
                Text('Зарядного устройства для вашего автомобиля',
                    style: context.textTheme.bodyMedium),
                const SizedBox(height: 16),
                TopLocation(constraints: constraints),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      width: constraints.maxWidth / 1.2,
                      onTap: () {
                        context.router.push(const AccountSetupLocationRoutePage());
                      },
                      text: 'Продолжить'),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
