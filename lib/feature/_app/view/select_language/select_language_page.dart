import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/helpers/app_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/application.dart';
import '../../../../core/provider/theme_notifier.dart';
import '../../../../core/router/router.gr.dart';
import '../../widgets/custom_button.dart';

@RoutePage(name: 'SelectLanguagePageRoute')
class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  final listLanguage = [
    {'language': 'English', 'code': 'en'},
    {'language': "Русский язык", 'code': 'ru'},
    {'language': "O'zbek tili", 'code': 'uz'},
    {'language': 'Китайский язык(中国语文科)', 'code': 'cn'},
    {'language': 'Киргизский язык(Кыргыз тили)', 'code': 'kg'},
    {'language': 'Таджикский язык(Забони тоҷикӣ)', 'code': 'tj'},
  ];

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
    Provider.of<ThemeNotifier>(context, listen: false);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Выберите язык',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              boxShadow: [
                BoxShadow(
                  color: context.theme.shadowColor.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 7), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                for (var x in listLanguage) ...[
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      themeNotifier.changeLanguage('${x['code']}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/${x['code']}.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              '${x['language']}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(width: 2),
                           themeNotifier.appLocal.languageCode == x['code']
                              ? Image.asset("assets/check.png",
                                  color: Colors.white)
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          16.height,
          CustomButton(
            width: context.screenSize.width / 1.2,
            onTap: () {
              final token = AppUser.token;
                if (token != null) {
                  context.router.push(const DashboardPageRoute());
                } else {
                  if (Application.language != null) {
                    context.router.push(const SignInFormRoutePage());
                  }
                }
            },
            text: 'Продолжить',
          ),
        ],
      ),
    ));
  }
}
