import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/throw_error.dart';
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

  @override
  void initState() {
    _repository = AccountSetupRepository();
    _bloc = AccountSetupBloc(repository: _repository);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(
                    title: 'Политика конфиденциальности',
                    supplementary: '',
                    description:
                        'Заявление о том, что пользователь соглашается с Политикой конфиденциальности',
                  ),
                  16.height,
                  Checkbox(
                    value: value,
                    onChanged: (bool? newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                  ),
                  const Spacer(),
                  BlocConsumer<AccountSetupBloc, AccountSetupState>(
                    bloc: _bloc,
                    listener: (context, AccountSetupState state) {
                      state.maybeWhen(
                          success: () {
                            context.router
                                .push(const AccountSetupConnectorRoutePage());
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
                      return Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AnimatedOpacity(
                            opacity: value == true ? 1.0 : 0.5,
                            duration: const Duration(milliseconds: 500),
                            child: CustomButton(
                                width: constraints.maxWidth / 1.2,
                                onTap: () => value == true ? submit() : null,
                                text: 'Завершить'),
                          ),
                        ),
                      );
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
