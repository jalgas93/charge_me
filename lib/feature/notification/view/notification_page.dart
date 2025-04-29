import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../widget/item_notification.dart';
import '../widget/notifications_list.dart';

@RoutePage(name: "NotificationPageRoute")
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: AppColorsDark.white,
            onPressed: () async {
              context.router.popForced();
            },
          ),
          title: Text('Уведомление',style: context.textTheme.titleLarge),
          actions: [
            ItemAppBar(
              icon: 'assets/basket.png',
              colorIcon: AppColorsDark.white,
              onPressed: () async {},
            )
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            NotificationsList(
              itemCount: 10,
              child: ItemNotification(
                title: 'Emmett Perry',
                description:
                    'Just messaged you. Check the message in message tab.',
                time: '10 mins ago',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
