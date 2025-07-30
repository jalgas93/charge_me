import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/account/bloc/account_setup_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/app_user.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/helper_bottom_sheet.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/show_dialog_form.dart';
import '../../_app/widgets/skip_container.dart';
import '../../_app/widgets/status_widgets/success_status.dart';
import '../../_app/widgets/throw_error.dart';
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
      if(AppUser.userModel!.userId !=null){
        _bloc.add(AccountSetupEvent.updateUser(
          role: "USER",
          userId: AppUser.userModel!.userId!,
          firstname: _controllerFirstname.text.trim(),
        ));
      }else{
        ThrowError.showNotify(context: context, errMessage: 'User id null');
      }
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16,bottom: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: _keyboardVisible
                        ? constraints.maxHeight
                        : constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: TitleText(
                        title: 'Заполните вашу информацию',
                        description:
                            'Вы можете отредактировать это позже в настройках своей учетной записи.',
                      ),
                    ),
                    16.height,
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
                    16.height,
                    Form(
                      key: _formKey,
                      child: TextFormContainer(
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
                    ),
                    const Spacer(),
                    BlocConsumer<AccountSetupBloc, AccountSetupState>(
                      bloc: _bloc,
                      listener: (context, AccountSetupState state) {
                        state.maybeWhen(
                            error: (e){
                              ThrowError.showNotify(context: context, errMessage: e.toString());
                            },
                            success: () async {
                              await ShowDialogForm()
                                  .showInfo(context: context, text: 'sdsf');
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
      ),
    );
  }
}
