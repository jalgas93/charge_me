import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/feature/auth/view/register_form_page.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../core/utils/permission_until.dart';
import '../../../share/widgets/custom_button.dart';
import '../widget/text_form_container.dart';
import '../widget/title_text.dart';

@RoutePage(name: "SignInFormRoutePage")
class SingInFormPage extends StatefulWidget {
  const SingInFormPage({super.key});

  @override
  State<SingInFormPage> createState() => _SingInFormPageState();
}

class _SingInFormPageState extends State<SingInFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  16.height,
                  Image.asset('assets/car_2.png'),
                  const TitleText(
                    title: 'Let’s',
                    supplementary: 'Sign In',
                    description: 'Sing in to continue',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          width: constraints.maxWidth / 1.2,
                          onTap: () {
                            context.router.push(const DashboardPageRoute());
                            PermissionUtil.requestAll();
                          },
                          text: 'Login'),
                      16.height,
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: context.textTheme.bodyLarge,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?',
                          style: context.textTheme.bodyLarge),
                      TextButton(
                          onPressed: () {
                            context.router.push(const RegisterFormRoutePage());
                          },
                          child: Text('Register',
                              style: context.textTheme.titleSmall))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
