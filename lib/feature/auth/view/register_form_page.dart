import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/styles/app_colors_dark.dart';
import 'package:charge_me/feature/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/router.gr.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../auth_repository.dart';
import '../widget/lower_part.dart';
import '../widget/phone_field_widget.dart';
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
  final TextEditingController _controllerFirstname = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAvatar = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late AuthBloc _bloc;
  late AuthRepository _repository;
  bool _keyboardVisible = false;
  bool isObs = true;

  @override
  void initState() {
    _repository = AuthRepository();
    _bloc = AuthBloc(repository: _repository);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void submit() {
    if (_formRegister.currentState!.validate()) {
      _bloc.add(AuthEvent.registerWithUsername(
        username: _controllerUsername.text.trim(),
        phone: _controllerPhone.text.trim(),
        password: _controllerPassword.text.trim(),
        firstname: _controllerFirstname.text.trim(),
        avatar: _controllerAvatar.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
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
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: _keyboardVisible
                      ? constraints.maxHeight + constraints.maxWidth / 2
                      : constraints.maxHeight + constraints.maxWidth / 3),
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
                          controller: _controllerFirstname,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'First name',
                          onChanged: (event){
                            _formRegister.currentState!.validate();
                          },
                        ),
                        TextFormContainer(
                          controller: _controllerUsername,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'Username',
                          onChanged: (event){
                            _formRegister.currentState!.validate();
                          },
                        ),
                        TextFormContainer(
                          controller: _controllerPassword,
                          prefixIcon: 'assets/lock.png',
                          hintText: 'Password',
                          prefixColor: AppColorsDark.red2,
                          isObs: isObs,
                          isShow: true,
                          actionsButton: () {
                            setState(() {
                              isObs = !isObs;
                            });
                          },
                          onChanged: (event){
                            _formRegister.currentState!.validate();
                          },
                        ),
                        TextFormContainer(
                          controller: _controllerAvatar,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'Avatar',
                          onChanged: (event){
                            _formRegister.currentState!.validate();
                          },
                        ),
                        PhoneFieldWidget(
                          controller: _controllerPhone,
                          onChanged: (event){
                            _formRegister.currentState!.validate();
                          },
                        )
                      ],
                    ),
                  ),
                  const LowerPart(),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: _bloc,
                    listener: (context, AuthState state) {
                      state.maybeWhen(
                          successRegisterWithUsername: (result) {
                            context.router
                                .push(const RegisterFormOtpRoutePage());
                          },
                          orElse: () {});
                    },
                    builder: (context, state) {
                      return CustomButton(
                          width: constraints.maxWidth / 1.2,
                          onTap: () => submit(),
                          text: 'Register');
                    },
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
