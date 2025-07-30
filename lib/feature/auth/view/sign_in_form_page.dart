import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../core/utils/permission_until.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/throw_error.dart';
import '../auth_repository.dart';
import '../bloc/auth_bloc.dart';
import '../widget/phone_field_widget.dart';
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
  final focusNodePhone = FocusNode();
  final focusNodePassword = FocusNode();
  static final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isObs = true;
  bool _keyboardVisible = false;

  late AuthBloc _bloc;
  late AuthRepository _repository;

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
      _bloc.add(AuthEvent.loginWithPhone(
        phone: '+998${_controllerPhone.text.trim()}',
        password: _controllerPassword.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: _keyboardVisible
                      ? constraints.maxHeight + constraints.maxWidth / 3
                      : constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropShadowImage(
                        offset: const Offset(10, 10),
                        scale: 1,
                        blurRadius: 25,
                        borderRadius: 25,
                        image: Image.asset(
                          'assets/charger_new_color_2.png',
                          width: context.screenSize.width / 3,
                        ),
                      ),
                      Image.asset('assets/car_2.png'),
                    ],
                  ),
                  const TitleText(
                    title: 'Let’s Sign In',
                    description: 'Sing in to continue',
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
                          onEditingComplete: () {
                            focusNodePassword.unfocus();
                            _formKey.currentState!.validate();
                          },
                          actionsButton: () {
                            setState(() {
                              isObs = !isObs;
                            });
                          },
                          inputFormatters: [],
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<AuthBloc, AuthState>(
                        bloc: _bloc,
                        listener: (context, AuthState state) {
                          state.maybeWhen(
                              successLoginWithPhone: (result) {
                                context.router.pushAndPopUntil(
                                    const DashboardPageRoute(),
                                    predicate: (Route<dynamic> route) => false);
                                PermissionUtil.requestAll();
                              },
                              error: (e) {
                                ThrowError.showNotify(
                                    context: context, errMessage: "$e");
                              },
                              orElse: () {});
                        },
                        builder: (context, AuthState state) {
                          final isLoading = state == const AuthState.loading();
                          return  state.maybeWhen(
                              loading: () {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              orElse: () {
                               return CustomButton(
                                    isLoading: isLoading,
                                    width: constraints.maxWidth / 1.2,
                                    onTap: () => submit(),
                                    text: 'Login');
                              });
                        },
                      ),
                      16.height,
                      TextButton(
                          onPressed: () {
                            context.router
                                .push(const PasswordChangeRoutePage());
                          },
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
