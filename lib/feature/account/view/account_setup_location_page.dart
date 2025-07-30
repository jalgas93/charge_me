import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/helpers/app_user.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/feature/account/model/yandex_address/response_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/app_colors_dark.dart';
import '../../_app/widgets/app_bar_container.dart';
import '../../_app/widgets/custom_button.dart';
import '../../_app/widgets/item_app_bar.dart';
import '../../_app/widgets/skip_container.dart';
import '../../_app/widgets/throw_error.dart';
import '../account_repository.dart';
import '../bloc/account_setup_bloc.dart';
import '../widget/second_container_map.dart';
import '../widget/title_fields.dart';

@RoutePage(name: "AccountSetupLocationRoutePage")
class AccountSetupLocationPage extends StatefulWidget {
  const AccountSetupLocationPage({super.key});

  @override
  State<AccountSetupLocationPage> createState() =>
      _AccountSetupLocationPageState();
}

class _AccountSetupLocationPageState extends State<AccountSetupLocationPage> {
  late AccountSetupBloc _bloc;
  late AccountSetupRepository _repository;
  String? address;
  double? latitude;
  double? longitude;

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
    if (address != null && latitude != null && longitude != null) {
      if (AppUser.userModel!.userId != null) {
        _bloc.add(AccountSetupEvent.addLocation(
            latitude: latitude!,
            longitude: longitude!,
            road: address,
            userId: AppUser.userModel!.userId!));
      } else {
        ThrowError.showNotify(context: context, errMessage: 'User id null');
      }
    } else {
      ThrowError.showNotify(
          context: context, errMessage: 'Укажите ваше местоположения');
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
                context.router.push(const AccountSetupUserRoutePage());
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TitleFields(
                field: 'Добавьте свое',
                field2: ' местоположение',
                field3: '',
              ),
              SecondContainerMap(
                constraints: constraints,
                onTap: () async {
                  ResponseResult? result =
                      await context.router.push(const YandexMapPageRoute());
                  if (result?.address != null) {
                    address = result!.address!;
                  }
                  if (result?.point?.latitude != null) {
                    latitude = result?.point?.latitude;
                  }
                  if (result?.point?.longitude != null) {
                    longitude = result?.point?.longitude;
                  }
                  setState(() {});
                },
                isLocation: false,
                address: address,
              ),
              const Spacer(),
              BlocConsumer<AccountSetupBloc, AccountSetupState>(
                bloc: _bloc,
                listener: (context, AccountSetupState state) {
                  state.maybeWhen(
                    error: (e){
                      ThrowError.showNotify(context: context, errMessage: e.toString());
                    },
                      successAddLocation: () {
                        context.router.push(const AccountSetupUserRoutePage());
                      },
                      orElse: () {});
                },
                builder: (context, state) {
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
