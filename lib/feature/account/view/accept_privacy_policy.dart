import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/application.dart';
import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/throw_error.dart';
import '../../auth/widget/title_text.dart';
import '../account_repository.dart';
import '../bloc/account_setup_bloc.dart';

@RoutePage(name: 'AcceptPrivacyPoliceRoutePage')
class AcceptPrivacyPolicy extends StatefulWidget {
  const AcceptPrivacyPolicy({super.key});

  @override
  State<AcceptPrivacyPolicy> createState() => _AcceptPrivacyPolicyState();
}

class _AcceptPrivacyPolicyState extends State<AcceptPrivacyPolicy> {
  late AccountSetupBloc _bloc;
  late AccountSetupRepository _repository;
  bool _keyboardVisible = false;
  bool? value = false;
  late final WebViewController _controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    _repository = AccountSetupRepository();
    _bloc = AccountSetupBloc(repository: _repository);
    _controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://prod.tazaquat.kz'),
        headers: {'Accept-Language': Application.language!},
      );
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void submit() async {
    if (value == true) {
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
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(
                      title: 'Правила и политика конфиденциальности',
                      description:
                          'Заявление о том, что пользователь соглашается с Политикой конфиденциальности',
                    ),
                    16.height,
                    Expanded(
                      child: WebViewWidget(controller: _controller),
                    ),
                    16.height,
                    Row(
                      children: [
                        Checkbox(
                          value: value,
                          onChanged: (bool? newValue) {
                            setState(() {
                              value = newValue;
                            });
                          },
                        ),
                        Flexible(
                          child: Text(
                            'С документом выше ознакомлен(а) и согласен(-на)',
                            style: context.textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                    16.height,
                    BlocConsumer<AccountSetupBloc, AccountSetupState>(
                      bloc: _bloc,
                      listener: (context, AccountSetupState state) {
                        state.maybeWhen(
                            error: (e) {
                              ThrowError.showNotify(
                                  context: context, errMessage: e.toString());
                            },
                            success: () {
                              context.router
                                  .push(const AccountSetupCarRoutePage());
                            },
                            orElse: () {});
                      },
                      builder: (context, AccountSetupState state) {
                        final isLoading =
                            state == const AccountSetupState.loading();
                        return state.maybeWhen(orElse: () {
                          return Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AnimatedOpacity(
                                opacity: value == true ? 1.0 : 0.5,
                                duration: const Duration(milliseconds: 500),
                                child: CustomButton(
                                    isLoading: isLoading,
                                    width: constraints.maxWidth / 1.2,
                                    onTap: () =>
                                        value == true ? submit() : null,
                                    text: 'Продолжить'),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
