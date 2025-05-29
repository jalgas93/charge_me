import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/share/widgets/throw_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../auth/widget/social_network.dart';

@RoutePage(name: "SupportServicePage")
class SupportServicePage extends StatefulWidget {
  const SupportServicePage({super.key});

  @override
  State<SupportServicePage> createState() => _SupportServicePageState();
}

class _SupportServicePageState extends State<SupportServicePage> {
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
          title: Text(
            "Поддержка",
            style: context.textTheme.titleSmall,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 50),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          SocialNetwork(
            onTap: () async{
                  await launch(
                    "https://t.me/podrabotkaApp",
                    forceSafariVC: false,
                    forceWebView: false,
                    headers: <String, String>{
                      'my_header_key': 'my_header_value'
                    },
                  );
            },
            isSelected: false,
            image: 'assets/tg.png',
          ),
          SocialNetwork(
            onTap: () {
              ThrowError.showMessage(errMessage: "Скоро", context: context);
            },
            isSelected: false,
            image: 'assets/wechat.png',
          ),
          SocialNetwork(
            onTap: () {
              ThrowError.showMessage(errMessage: "Скоро", context: context);
            },
            isSelected: false,
            image: 'assets/whatsapp.png',
          ),
        ]),
      ),
    );
  }
  ////
}
