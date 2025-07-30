import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/helper_bottom_sheet.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/status_widgets/success_status.dart';
import '../../_app/widgets/throw_error.dart';
import '../../auth/widget/phone_field_widget.dart';
import '../../auth/widget/text_form_container.dart';
import '../../auth/widget/title_text.dart';
import '../account_repository.dart';
import '../bloc/account_setup_bloc.dart';

@RoutePage(name: 'PasswordChangeRoutePage')
class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNodePhone = FocusNode();
  final focusNodeNew = FocusNode();
  final focusNodeConfirm = FocusNode();

  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirm = TextEditingController();
  late AccountSetupBloc _bloc;
  late AccountSetupRepository _repository;
  bool _keyboardVisible = false;
  bool isObs = true;

  @override
  void initState() {
    _repository = AccountSetupRepository();
    _bloc = AccountSetupBloc(repository: _repository);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    focusNodePhone.dispose();
    focusNodeNew.dispose();
    focusNodeConfirm.dispose();
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _bloc.add(const AccountSetupEvent.started());
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
                      : constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TitleText(
                    title: 'Изменение пароля',
                    description:
                        'Введите свой номер телефона и новый пароль ниже, чтобы сбросить пароль',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PhoneFieldWidget(
                          autovalidateMode: AutovalidateMode.disabled,
                          focusNode: focusNodePhone,
                          controller: _controllerPhone,
                          onChanged: (value) {},
                          onSubmitted: (value) {
                            _formKey.currentState!.validate();
                            FocusScope.of(context).requestFocus(focusNodeNew);
                          },
                        ),
                        TextFormContainer(
                          focusNode: focusNodeNew,
                          controller: _controllerPassword,
                          prefixIcon: 'assets/lock.png',
                          hintText: 'Новый пароль',
                          prefixColor: AppColorsDark.red2,
                          isObs: isObs,
                          isShow: true,
                          actionsButton: () {
                            setState(() {
                              isObs = !isObs;
                            });
                          },
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(focusNodeConfirm);
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        TextFormContainer(
                          focusNode: focusNodeConfirm,
                          controller: _controllerConfirm,
                          prefixIcon: 'assets/lock.png',
                          hintText: 'Подтвердите пароль',
                          prefixColor: AppColorsDark.red2,
                          isObs: isObs,
                          isShow: true,
                          actionsButton: () {
                            setState(() {
                              isObs = !isObs;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value == '') {
                              return 'Обязательное поле';
                            }
                            if (value != _controllerPassword.text) {
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            focusNodeConfirm.unfocus();
                            _formKey.currentState!.validate();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AccountSetupBloc, AccountSetupState>(
                    bloc: _bloc,
                    listener: (context, AccountSetupState state) {
                      state.maybeWhen(
                          error: (e){
                            ThrowError.showNotify(context: context, errMessage: e.toString());
                          },
                          success: () {
                            context.router
                                .push(RegisterFormOtpRoutePage(requestId: '',phone: ''));
                          },
                          orElse: () {});
                    },
                    builder: (context, AccountSetupState state) {
                      state.maybeWhen(
                          loading: () {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          error: (e) {
                            ThrowError.showNotify(
                                context: context, errMessage: "Error");
                          },
                          orElse: () {});
                      return CustomButton(
                          width: constraints.maxWidth / 1.2,
                          onTap: () => submit(),
                          text: 'Завершить');
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
