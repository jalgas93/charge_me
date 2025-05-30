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
import '../../../share/widgets/throw_error.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNodePhone = FocusNode();
  final focusNodePassword = FocusNode();
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
    focusNodePhone.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(AuthEvent.registerWithTelegram(
        phone: '+998${_controllerPhone.text.trim()}',
        password: _controllerPassword.text.trim(),
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
                      ? constraints.maxHeight + constraints.maxWidth / 3
                      : constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TitleText(
                    title: 'Create your',
                    supplementary: 'account',
                    description: 'Давайте познакомимся',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PhoneFieldWidget(
                          autovalidateMode: AutovalidateMode.disabled,
                          focusNode: focusNodePhone,
                          controller: _controllerPhone,
                          onSubmitted: (value) {
                            _formKey.currentState!.validate();
                            FocusScope.of(context)
                                .requestFocus(focusNodePassword);
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        TextFormContainer(
                          focusNode: focusNodePassword,
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
                          onEditingComplete: () {
                            focusNodePassword.unfocus();
                            _formKey.currentState!.validate();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  const LowerPart(),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: _bloc,
                    listener: (context, AuthState state) {
                      state.maybeWhen(
                          successRegisterWithTelegram: (result) {
                            var requestId = result;
                            context.router
                                .push(RegisterFormOtpRoutePage(requestId: ''));
                          },
                          error: (e) {
                            ThrowError.showNotify(
                                context: context, errMessage: "Error");
                          },
                          orElse: () {});
                    },
                    builder: (context, AuthState state) {
                      state.maybeWhen(
                          loading: () {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          orElse: () {});
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
