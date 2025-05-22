import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/feature/account/bloc/account_setup_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../../share/widgets/item_app_bar.dart';
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
  final TextEditingController _controllerPhone = TextEditingController();
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

  void submit() {
    if (_formAccount.currentState!.validate()) {

    }
  }
  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
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
      body: Padding(
          padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
