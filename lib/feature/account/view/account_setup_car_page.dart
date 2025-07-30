import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:charge_me/core/helpers/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logging/log.dart';
import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/skip_container.dart';
import '../../_app/widgets/throw_error.dart';
import '../account_repository.dart';
import '../bloc/account_setup_bloc.dart';
import '../utils/account_utils.dart';
import '../widget/connector_selection.dart';

@RoutePage(name: "AccountSetupCarRoutePage")
class AccountSetupCarPage extends StatefulWidget {
  const AccountSetupCarPage({super.key});

  @override
  State<AccountSetupCarPage> createState() => _AccountSetupCarPageState();
}

class _AccountSetupCarPageState extends State<AccountSetupCarPage> {
  late AccountSetupBloc _bloc;
  late AccountSetupRepository _repository;

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
    Log.i("UserId",AppUser.userModel?.userId!);
    if(AppUser.userModel?.userId != null){
      _bloc.add(const AccountSetupEvent.addCar(
          manufacture: 'BYD',
          model: 'Chazor',
          connector: 'CHAdeMo',
          makeYear: '2021',
          registrationNumber: 'RJ14 XX1987',
          batteryCapacity: '12',
          plug: '30 kW',
          userId: 4
      ));
    }

  }

  @override
  Widget build(BuildContext context) {
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
                context.router.push(const AccountSetupLocationRoutePage());
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Выбор разъёма', style: context.textTheme.headlineMedium),
              Text('Зарядного устройства для вашего автомобиля',
                  style: context.textTheme.bodyMedium),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: AccountUtils.isConnectorSelection,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConnectorSelection(
                            constraints: constraints,
                            isSelected: value == SelectConnectors.gbt ||
                                value == SelectConnectors.all,
                            image: "assets/gbt.png",
                            title: "GBT",
                            numbering: "#1",
                            onTap: () {
                              AccountUtils.setIsConnectorSelection =
                                  SelectConnectors.gbt;
                            },
                          ),
                          ConnectorSelection(
                            constraints: constraints,
                            isSelected: value == SelectConnectors.cc2 ||
                                value == SelectConnectors.all,
                            image: "assets/gbt.png",
                            title: "GBT",
                            numbering: "#2",
                            onTap: () {
                              AccountUtils.setIsConnectorSelection =
                                  SelectConnectors.cc2;
                            },
                          ),
                        ],
                      ),
                      16.height,
                      GestureDetector(
                        onTap: () {
                          AccountUtils.setIsConnectorSelection =
                              SelectConnectors.all;
                        },
                        child: Container(
                          height: constraints.maxWidth / 5,
                          width: constraints.maxWidth / 5,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                              color: AppColorsDark.whiteSecondary,
                              borderRadius: BorderRadius.circular(25)),
                          child: Text('Все',
                              style: context.textTheme.titleSmall?.copyWith(
                                  color: AppColorsDark.darkStyleText)),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              BlocConsumer<AccountSetupBloc, AccountSetupState>(
                bloc: _bloc,
                listener: (context, AccountSetupState state) {
                  state.maybeWhen(
                      error: (e) {
                        ThrowError.showNotify(
                            context: context, errMessage: "$e");
                      },
                      orElse: () {});
                },
                builder: (context, AccountSetupState state) {
                  state.maybeWhen(
                      successAddCar: () {
                        context.router.push(const AccountSetupLocationRoutePage());
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                      orElse: () {});
                  return Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                        width: constraints.maxWidth / 1.2,
                        onTap: submit,
                        text: 'Продолжить'),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
