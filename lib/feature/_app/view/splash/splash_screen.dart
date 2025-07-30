import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/application.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';
import 'package:drop_shadow/drop_shadow.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/app_user.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/styles/app_colors_dark.dart';
import '../../../../core/utils/permission_until.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../widgets/custom_button.dart';
//  return const UserProvider(child: _SplashPage());

@RoutePage(name: "SplashPageRoute")
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late AppBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/charger.png"), context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //FirebaseMessaging.instance.getToken().then((value) => print(value));
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColorsDark.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            16.height,
            SizedBox(
              height: context.screenSize.height / 2,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: DropShadow(
                        color: AppColorsDark.green1,
                        spread: 0,
                        child: Image.asset(
                          "assets/charger.png",
                          width: context.screenSize.width,
                        )),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/charge.png'),
                          8.width,
                          Column(
                            children: [
                              Text(
                                'SUPER',
                                style: context.textTheme.headlineLarge?.copyWith(
                                    fontSize: 16, height: 1, letterSpacing: 3),
                              ),
                              Text(
                                'CHARGE',
                                style: context.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14, height: 1, letterSpacing: 2),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Добро пожаловать! Готов зарядить ваш автомобиль с энергией",
                style: context.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            BlocConsumer(
              bloc: _bloc,
              listener: (BuildContext context, AppState state) {
                state.maybeWhen(
                    success: ()async {
                      final token = AppUser.token;
                      if (context.mounted) {
                        if (token != null) {
                          context.router.push(const DashboardPageRoute());
                        } else {
                          if (Application.language != null) {
                            context.router.push(const SignInFormRoutePage());
                          } else {
                            context.router
                                .push(const SelectLanguagePageRoute());
                          }
                        }
                      }
                    },
                    orElse: () {});
              },
              builder: (BuildContext context, AppState state) {
                final isLoading = state == const AppState.loading();
                return state.maybeWhen(
                    orElse: () {
                  return CustomButton(
                    isLoading: isLoading,
                    width: context.screenSize.width / 1.2,
                    onTap: () {
            /*          sendNotification(
                          token: 'FCM_TOKEN',
                          title: 'Hello Abdallah!',
                          body: 'This is a new test notification.',
                          data: {
                            "route": "/product_detials",
                            "id": "120",
                          });*/
                      _bloc.add(const AppEvent.started());
                      PermissionUtil.requestAll();
                    },
                    text: 'Продолжить',
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
