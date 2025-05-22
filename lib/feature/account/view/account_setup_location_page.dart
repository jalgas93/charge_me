import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../widget/second_container_map.dart';
import '../widget/title_fields.dart';

@RoutePage(name: "AccountSetupLocationRoutePage")
class AccountSetupLocationPage extends StatefulWidget {
  const AccountSetupLocationPage({super.key});

  @override
  State<AccountSetupLocationPage> createState() =>
      _AccountSetupLocationPageState();
}

class _AccountSetupLocationPageState extends State<AccountSetupLocationPage> {
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
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TitleFields(
                field: 'Where is the ',
                field2: 'location',
                field3: ' ?',
              ),
              SecondContainerMap(
                constraints: constraints,
                onPressed: (){
                  // context.router.push(const YandexMapPageRoute());
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                    width: constraints.maxWidth / 1.2,
                    onTap: () {
                      context.router.push(const AccountSetupUserRoutePage());
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
