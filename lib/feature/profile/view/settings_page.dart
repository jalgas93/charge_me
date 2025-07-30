import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/application.dart';
import '../../../core/provider/theme_notifier.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/item_app_bar.dart';

@RoutePage(name: "SettingRoutePage")
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? _openedAccordion;
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
      appBar: AppBarContainer(
        appBar: AppBar(
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: Colors.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _openedAccordion = index == _openedAccordion ? null : index;
                });
              },
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        title: Text(
                          'Язык',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w500),
                        ));
                  },
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                  isExpanded: _openedAccordion == 0,
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: Colors.white,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        title: Text(
                          '2',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ));
                  },
                  body: Column(
                    children: [

                    ],
                  ),
                  isExpanded: _openedAccordion == 1,
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: Colors.white,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        title: Text(
                          '3',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ));
                  },
                  body: Column(
                    children: [

                    ],
                  ),
                  isExpanded: _openedAccordion == 2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
