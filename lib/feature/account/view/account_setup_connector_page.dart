import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/account/utils/account_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/skip_container.dart';
import '../widget/connector_selection.dart';

@RoutePage(name: "AccountSetupConnectorRoutePage")
class AccountSetupConnectorPage extends StatefulWidget {
  const AccountSetupConnectorPage({super.key});

  @override
  State<AccountSetupConnectorPage> createState() =>
      _AccountSetupConnectorPageState();
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
          actions: [
            SkipContainer(
              onTap: (){
                context.router.push(const AccountSetupLocationRoutePage());
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Выбор разъёма', style: context.textTheme.headlineMedium),
              Text('Зарядного устройства для вашего автомобиля',
                  style: context.textTheme.bodyMedium),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: AccountUtils.isConnectorSelection,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConnectorSelection(
                            constraints: constraints,
                            isSelected: value == SelectConnectors.gbt ||
                                value == SelectConnectors.all,
                            image: "assets/gbt.png",
                            title: "GBT",
                            numbering: "#1",
                            onTap: () {
                              AccountUtils.setIsConnectorSelection =
                                  SelectConnectors.gbt;
                            },
                          ),
                          ConnectorSelection(
                            constraints: constraints,
                            isSelected: value == SelectConnectors.cc2 ||
                                value == SelectConnectors.all,
                            image: "assets/gbt.png",
                            title: "GBT",
                            numbering: "#2",
                            onTap: () {
                              AccountUtils.setIsConnectorSelection =
                                  SelectConnectors.cc2;
                            },
                          ),
                        ],
                      ),
                      16.height,
                      GestureDetector(
                        onTap: () {
                          AccountUtils.setIsConnectorSelection =
                              SelectConnectors.all;
                        },
                        child: Container(
                          height: constraints.maxWidth / 5,
                          width: constraints.maxWidth / 5,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                              color: AppColorsDark.whiteSecondary,
                              borderRadius: BorderRadius.circular(25)),
                          child: Text('Все',
                              style: context.textTheme.titleSmall?.copyWith(
                                  color: AppColorsDark.darkStyleText)),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                    width: constraints.maxWidth / 1.2,
                    onTap: () {
                      context.router
                          .push(const AccountSetupLocationRoutePage());
                    },
                    text: 'Продолжить'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
