import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/auth/widget/social_network.dart';
import 'package:flutter/material.dart';

import '../utils/auth_utils.dart';
import '../view/register_form_page.dart';

class LowerPart extends StatelessWidget {
  const LowerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            "На какие социальные сети отправить смс для подтверждения пользователя ?",
            style: context.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
        16.height,
         ValueListenableBuilder(
           valueListenable: AuthUtils.isSocialNetwork,
           builder: (context,value,child){
             return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   SocialNetwork(
                     onTap: (){
                       AuthUtils.setIsSocialNetwork = 0;
                     },
                     isSelected: value ==0,
                     image: 'assets/tg.png',
                   ),
                   SocialNetwork(
                     onTap: (){
                       AuthUtils.setIsSocialNetwork = 1;
                     },
                     isSelected: value ==1,
                     image: 'assets/wechat.png',
                   ),
                   SocialNetwork(
                     onTap: (){
                       AuthUtils.setIsSocialNetwork = 2;
                     },
                     isSelected: value == 2,
                     image: 'assets/whatsapp.png',
                   ),
                 ]);
           },
         ),
      ],
    );
  }
}
