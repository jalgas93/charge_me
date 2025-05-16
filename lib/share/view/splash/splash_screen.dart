import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/application.dart';
import 'package:charge_me/core/extensions/context_extensions.dart';
import 'package:charge_me/core/extensions/empty_space.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router/router.gr.dart';
import '../../../core/styles/app_colors_dark.dart';
import '../../../core/utils/flutter_secure_storage.dart';
import '../../../core/utils/permission_until.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../utils/permission_until.dart';
import '../../widgets/custom_button.dart';

@RoutePage(name: "SplashPageRoute")
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/car.png"), context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
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
              height: context.screenSize.height / 2.2,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40, top: 70),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/ellipse.png"),
                      fit: BoxFit.contain,
                    )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/car.png"),
                      fit: BoxFit.contain,
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
                      final token = await SecureStorageService.getInstance
                          .getValue("access_token");
                      if (context.mounted) {
                        if (token != null) {
                          context.router.push(const DashboardPageRoute());
                        } else {
                          if (Application.language != null) {
                            context.router.push(const LoginOptionRoutePage());
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
                return state.maybeWhen(orElse: () {
                  return CustomButton(
                    width: context.screenSize.width / 1.2,
                    onTap: () {
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
