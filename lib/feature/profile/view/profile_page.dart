import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/profile/widget/item_icon_container.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../widget/item_container.dart';
import '../widget/profile_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Профиль', style: context.textTheme.titleLarge),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ItemAppBar(
                icon: 'assets/bell.png',
                colorIcon: AppColorsDark.white,
                colorBorder: AppColorsDark.secondaryColor3,
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileContainer(
              email: 'mathew@email.com',
              name: 'Mathew Adam',
              avatar: 'assets/images/IMG_3.jpg',
              onTap: () {
                context.router.push(const EditProfilePageRoute());
              },
            ),
            ItemContainer(
              title: 'Кошелек',
              colorIcon: AppColorsDark.indigo1,
              image: 'assets/card.png',
              description: '247 700 000 сум',
              onTap: (){
                context.router.push(const WalletRoutePage());
              },
            ),
            ItemContainer(
              title: 'Настройки',
              colorIcon: AppColorsDark.blue3,
              image: 'assets/setting.png',
              onTap: (){
                context.router.push(const SettingRoutePage());
              },
            ),
            ItemContainer(
              title: 'Служба поддержки',
              image: 'assets/message.png',
              colorIcon: AppColorsDark.green1,
              onTap: (){
                context.router.push(const SupportServicePage());
              },
            ),
            ItemContainer(
              title: 'Условия использования',
              colorIcon: AppColorsDark.blue1,
              image: 'assets/contract.png',
              onTap: (){
                context.router.push(const TermsOfUsePage());
              },
            ),
            ItemContainer(
              title: 'О нас',
              colorIcon: AppColorsDark.yellow1,
              image: 'assets/info.png',
              onTap: (){
                context.router.push(const AboutAppRoutePage());
              },
            ),
            ItemContainer(
              title: 'Выйти из аккаунта',
              colorIcon: AppColorsDark.red1,
              colorText: AppColorsDark.red2,
              image: 'assets/sign_out.png',
              onTap: (){
                context.router.pushAndPopUntil(
                    const SignInFormRoutePage(),
                    predicate: (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
