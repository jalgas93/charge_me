import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../auth/widget/title_text.dart';

@RoutePage(name: "AboutAppRoutePage")
class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/car.png"), context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: context.screenSize.height / 2,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: DropShadow(
                        color: AppColorsDark.green1,
                        spread: 2,
                        child: Image.asset(
                          "assets/charger.png",
                          width: context.screenSize.width,
                        )),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/charge.png'),
                          8.width,
                          Column(
                            children: [
                              Text(
                                'SUPER',
                                style: context.textTheme.headlineLarge?.copyWith(
                                    fontSize: 16, height: 1, letterSpacing: 3),
                              ),
                              Text(
                                'CHARGE',
                                style: context.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14, height: 1, letterSpacing: 2),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Добро пожаловать в TAZAQUAT – инновационное решение для зарядки электромобилей!",
                style: context.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            16.height,
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TitleText(
                title: 'Наша миссия',
                description:
                'Мы стремимся сделать зарядку электромобилей простой, быстрой и доступной для всех. Наше приложение объединяет водителей и зарядные станции, помогая находить ближайшие точки подзарядки, бронировать их и оплачивать услуги в несколько кликов',
              ),
            ),
            16.height,
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Что мы предлагаем?', style: context.textTheme.titleMedium),
                  Text('🔹 Удобный поиск – карта с актуальными зарядными станциями рядом с вами.', style: context.textTheme.bodyMedium),
                  Text('🔹 Быстрая оплата – поддержка различных способов оплаты без комиссий.', style: context.textTheme.bodyMedium),
                  Text('🔹 Умное бронирование – резервируйте станции заранее и избегайте очередей.', style: context.textTheme.bodyMedium),
                  Text('🔹 Персональные уведомления – следите за статусом зарядки и получайте напоминания.', style: context.textTheme.bodyMedium),
                  Text('🔹 Экологичность – помогаем сокращать углеродный след, поддерживая переход на электромобили.', style: context.textTheme.bodyMedium),
                ],
              ),
            ),
            16.height,
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TitleText(
                title: 'Наша команда',
                description:
                'Мы – команда энтузиастов, объединённых идеей устойчивого будущего. Наши разработчики, экологи и бизнес-аналитики работают над тем, чтобы ваше взаимодействие с зарядной инфраструктурой было максимально комфортным.',
              ),
            ),
            16.height,
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Присоединяйтесь к нам!', style: context.textTheme.titleMedium),
                  Text('Скачивайте приложение и становитесь частью сообщества, которое меняет мир к лучшему.', style: context.textTheme.bodyMedium),
                  Text('Ссылки на App Store и Google Play', style: context.textTheme.bodyMedium),
                  Text('📧 Контакты: [ваш email]', style: context.textTheme.bodyMedium),
                ],
              ),
            ),
            16.height,
            Text('Заряжайтесь легко с Tazaquat! ⚡🚗', style: context.textTheme.bodyMedium),
            16.height,
          ],
        ),
      ),
    );
  }
}
