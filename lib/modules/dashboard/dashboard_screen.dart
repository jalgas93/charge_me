import 'package:charge_me/modules/dashboard/utils/utils_dashboard.dart';
import 'package:charge_me/modules/history/view/history_page.dart';
import 'package:charge_me/modules/profile/view/profile_page.dart';
import 'package:charge_me/modules/support/view/support_page.dart';
import 'package:flutter/material.dart';
import '../home/view/home_page.dart';

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
    HistoryPage(),
    SupportPage(),
    ProfilePage()
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
      backgroundColor: Colors.grey.shade100,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nextPage(4);
            UtilsDashboard.setIsSelected = 4;
          },
          shape: const CircleBorder(),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1A8C35).withOpacity(0.32),
                    offset: const Offset(0, -1.15),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff9A22F9),
                    Color(0xffB0C7EE),
                    Color(0xffB7FCEB),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )),
            child: Image.asset('assets/car.png'),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: ValueListenableBuilder(
            valueListenable: UtilsDashboard.isSelected,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(0);
                          UtilsDashboard.setIsSelected = 0;
                        },
                        icon: Icon(
                          Icons.map,
                          color: value == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      )),
                      Text(
                        'Карта',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: value == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(1);
                          UtilsDashboard.setIsSelected = 1;
                        },
                        icon: Icon(
                          Icons.history,
                          color: value == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      )),
                      Text(
                        'История',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: value == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(2);
                          UtilsDashboard.setIsSelected = 2;
                        },
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: value == 2
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      )),
                      Text(
                        'Связь',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: value == 2
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {
                          nextPage(3);
                          UtilsDashboard.setIsSelected = 3;
                        },
                        icon: Icon(
                          Icons.person_outlined,
                          color: value == 3
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      )),
                      Text(
                        'Профиль',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: value == 3
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                      )
                    ],
                  )
                ],
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
