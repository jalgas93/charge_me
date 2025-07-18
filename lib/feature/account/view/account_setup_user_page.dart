import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/account/bloc/account_setup_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/app_bar_container.dart';
import '../../../share/widgets/custom_button.dart';
import '../../../share/widgets/helper_bottom_sheet.dart';
import '../../../share/widgets/item_app_bar.dart';
import '../../../share/widgets/show_dialog_form.dart';
import '../../../share/widgets/skip_container.dart';
import '../../../share/widgets/status_widgets/success_status.dart';
import '../../auth/widget/text_form_container.dart';
import '../../auth/widget/title_text.dart';
import '../account_repository.dart';

@RoutePage(name: "AccountSetupUserRoutePage")
class AccountSetupUserPage extends StatefulWidget {
  const AccountSetupUserPage({super.key});

  @override
  State<AccountSetupUserPage> createState() => _AccountSetupUserPageState();
}

class _AccountSetupUserPageState extends State<AccountSetupUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNodeFirstName = FocusNode();
  final TextEditingController _controllerFirstname = TextEditingController();
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
    focusNodeFirstName.dispose();
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
          actions: [
            SkipContainer(
              onTap: () {
                context.router.push(const DashboardPageRoute());
              },
            )
          ],
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
                    title: 'Заполните вашу информацию',
                    supplementary: '',
                    description:
                        'Вы можете отредактировать это позже в настройках своей учетной записи.',
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        padding: const EdgeInsets.all(48),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorsDark.whiteSecondary,
                          image: DecorationImage(
                              image: AssetImage('assets/plus.png')),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormContainer(
                          focusNode: focusNodeFirstName,
                          controller: _controllerFirstname,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'First name',
                          onEditingComplete: () {
                            focusNodeFirstName.unfocus();
                            _formKey.currentState!.validate();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  //const Spacer(),
                  100.height,
                  BlocConsumer<AccountSetupBloc, AccountSetupState>(
                    bloc: _bloc,
                    listener: (context, AccountSetupState state) {
                      state.maybeWhen(
                          success: () async {
                            await ShowDialogForm().showInfo(context: context, text: 'sdsf');
                          },
                          orElse: () {});
                    },
                    builder: (context, state) {
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
