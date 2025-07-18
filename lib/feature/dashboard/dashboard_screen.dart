import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/feature/dashboard/utils/utils_dashboard.dart';
import 'package:charge_me/feature/scanner/view/scanner_page.dart';
import 'package:flutter/material.dart';
import '../../core/styles/app_colors_dark.dart';
import '../home/view/home_page.dart';
import '../location/view/location_page.dart';
import '../profile/view/profile_page.dart';
import '../support/view/support_page.dart';

@RoutePage(name: "DashboardPageRoute")
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  PageController controller = PageController();
  var listScreen = const [
    HomePage(),
    LocationPage(),
    ScannerPage(),
    SupportPage(),
    ProfilePage(),
  ];

  void nextPage(index) {
    setState(() {
      currentIndex = index;
      controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: ValueListenableBuilder(
            valueListenable: UtilsDashboard.isSelected,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColorsDark.onPrimary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                nextPage(0);
                                UtilsDashboard.setIsSelected = 0;
                              },
                              icon: Image.asset(
                                'assets/car_3.png',
                                color: value == 0
                                    ? context.theme.focusColor
                                    : context.theme.unselectedWidgetColor,
                              ))),
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(1);
                          UtilsDashboard.setIsSelected = 1;
                        },
                        icon: Container(
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(
                              'assets/map.png',
                              color: value == 1
                                  ? context.theme.focusColor
                                  : context.theme.unselectedWidgetColor,
                            )),
                      )),
                      Expanded(
                        child: Container(
                          height: context.screenSize.width / 7,
                          width: context.screenSize.width / 7,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColorsDark.green1),
                          child: IconButton(
                              onPressed: () {
                                nextPage(2);
                                UtilsDashboard.setIsSelected = 2;
                              },
                              icon: Icon(
                                Icons.qr_code_scanner,
                                color: value == 2
                                    ? context.theme.indicatorColor
                                    : context.theme.unselectedWidgetColor,
                              )),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(3);
                          UtilsDashboard.setIsSelected = 3;
                        },
                        icon: Image.asset(
                          'assets/chart.png',
                          color: value == 3
                              ? context.theme.focusColor
                              : context.theme.unselectedWidgetColor,
                        ),
                      )),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              nextPage(4);
                              UtilsDashboard.setIsSelected = 4;
                            },
                            icon: Image.asset(
                              'assets/profile.png',
                              color: value == 4
                                  ? context.theme.focusColor
                                  : context.theme.unselectedWidgetColor,
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        body: PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listScreen.length,
            itemBuilder: (context, index) {
              return listScreen[index];
            }));
  }
}
