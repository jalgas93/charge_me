import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.gr.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../widget/text_form_container.dart';
import '../widget/title_text.dart';

@RoutePage(name: "RegisterFormRoutePage")
class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: ItemAppBar(
            icon: 'assets/back.png',
            colorIcon: AppColorsDark.white,
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context,constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TitleText(
                    title: 'Create your',
                    supplementary: 'account',
                    description: 'Давайте познакомимся',
                  ),
                  Form(
                    key: _formRegister,
                    child: Column(
                      children: [
                        TextFormContainer(
                          controller: _controllerName,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'Full name',
                        ),
                        TextFormContainer(
                          controller: _controllerEmail,
                          prefixIcon: 'assets/email.png',
                          hintText: 'Email',
                        ),
                        TextFormContainer(
                          controller: _controllerPassword,
                          prefixIcon: 'assets/lock.png',
                          hintText: 'Password',
                          prefixColor: AppColorsDark.red2,
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  CustomButton(
                    width: constraints.maxWidth/1.2,
                      onTap: () {
                        context.router.push(const RegisterFormOtpRoutePage());
                      },
                      text: 'Register'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
