import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../../core/application.dart';
import '../../../core/router/router.gr.dart';
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
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.height,
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Выберите язык',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              50.height,
              Container(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 24,bottom: 24),
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
                          /*          ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

                          if (themeNotifier.appLocal == const Locale('en')) {
                            themeNotifier.changeLanguage('ru');
                          } else {
                            themeNotifier.changeLanguage('en');
                          }*/
                          Application.onAppLanguageChanged
                              ?.call(x['code'] ?? 'en');
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Application.language == x['code']
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
              SizedBox(height: context.screenSize.width / 4),
              CustomButton(
                width: context.screenSize.width / 1.2,
                onTap: () {
                  context.router.push(const DashboardPageRoute());
                },
                text: 'Продолжить',
              ),
            ],
          ),
        ));
  }
}
