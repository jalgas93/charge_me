import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/home/widget/tab_screens/car_status.dart';
import 'package:charge_me/feature/home/widget/tab_screens/climate.dart';
import 'package:charge_me/feature/home/widget/tab_screens/engine_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/theme_notifier.dart';
import '../../../core/styles/app_colors_dark.dart';
import 'dart:math' as math;

import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/item_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> _body = const [CarStatus(), EngineStatus(), Climate()];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    ThemeMode mode =
    brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              context.router.push(const SignInFormRoutePage());
            },
            child: ItemAppBar(
              icon: 'assets/profile_image.png',
              isIcon: true,
              colorBorder: AppColorsDark.secondaryColor3,
              onPressed: () {
                context.router.popForced();
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tesla Roadster',
                style:
                    context.textTheme.bodyLarge,
              ),
              Text(
                'Olivia Smith',
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
          actions: [
            Consumer<ThemeNotifier>(
              builder:
                  (BuildContext context, ThemeNotifier value, Widget? child) {
                return Row(
                  children: [
                    Transform.rotate(
                      angle: 325 * math.pi / 180,
                      child: IconButton(
                        icon: mode == value.themeMode
                            ? Icon(
                          Icons.nightlight,
                          color: Theme.of(context).iconTheme.color,
                        )
                            : Icon(Icons.sunny,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          ThemeNotifier themeNotifier =
                          Provider.of<ThemeNotifier>(context, listen: false);
                          if (themeNotifier.themeMode == ThemeMode.light) {
                            themeNotifier.setTheme(ThemeMode.dark);
                          } else {
                            themeNotifier.setTheme(ThemeMode.light);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          /*  IconButton(onPressed: (){
              context.router.push(const AcceptPrivacyPoliceRoutePage());
            }, icon: const Icon(Icons.add)),*/
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ItemAppBar(
                    icon: 'assets/bell.png',
                    colorIcon: AppColorsDark.white,
                    colorBorder: AppColorsDark.secondaryColor3,
                    onPressed: () {
                      context.router.push(const NotificationPageRoute());
                    },
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 17,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: constraints.maxWidth / 1.8,
                    width: constraints.maxWidth / 1.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF03DABB), width: 2)),
                    child: Container(
                      height: constraints.maxWidth / 2,
                      width: constraints.maxWidth / 2,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF03DABB), Color(0xFF03DA99)],
                          tileMode: TileMode.repeated,
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Container(
                        height: constraints.maxWidth / 2.5,
                        width: constraints.maxWidth / 2.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.theme.scaffoldBackgroundColor,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Colors.black12,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/energy.png',
                              height: 16,
                              width: 16,
                            ),
                            8.height,
                            Text('360',
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(fontSize: 40)),
                            8.height,
                            Text('Km',
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(
                                        fontSize: 20, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                16.height,
                Text(
                  'Total Charge',
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: const Color(0xFF00FFDA)),
                ),
                16.height,
                Flexible(
                  child: DefaultTabController(
                    length: 3, // Number of tabs
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: kToolbarHeight - 8.0,
                          child: TabBar(
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            dividerColor: Colors.transparent,
                            padding: const EdgeInsets.all(4),
                            labelStyle: context.textTheme.titleMedium,
                            unselectedLabelStyle:
                                context.textTheme.titleMedium?.copyWith(color: Colors.grey),
                            indicatorColor: const Color(0xFF03E1AA),
                            indicatorWeight: 2,
                            tabs: const [
                              Tab(text: "Monthly"),
                              Tab(text: "Daily"),
                              Tab(text: "Climate"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: _body,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
