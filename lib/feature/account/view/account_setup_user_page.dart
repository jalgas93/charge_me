import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
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
  final GlobalKey<FormState> _formAccount = GlobalKey<FormState>();
  final TextEditingController _controllerFirstname = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerAvatar = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
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
    super.dispose();
  }

  void submit()async {
    if (_formAccount.currentState!.validate()) {
      await HelperBottomSheet.draggableScrollableSheet(
          context: context,
          children: [
            const SuccessStatus(),
          ]);
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
              onTap: (){
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
                    description: 'Вы можете отредактировать это позже в настройках своей учетной записи.',
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
                            image: AssetImage('assets/plus.png')
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formAccount,
                    child: Column(
                      children: [
                        TextFormContainer(
                          controller: _controllerFirstname,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'First name',
                          onChanged: (event){
                            _formAccount.currentState!.validate();
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
                            _formAccount.currentState!.validate();
                          },
                        ),
                        TextFormContainer(
                          controller: _controllerAvatar,
                          prefixIcon: 'assets/profile2.png',
                          hintText: 'Avatar',
                          onChanged: (event){
                            _formAccount.currentState!.validate();
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AccountSetupBloc, AccountSetupState>(
                    bloc: _bloc,
                    listener: (context, AccountSetupState state) {
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
