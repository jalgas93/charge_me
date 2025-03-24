import 'dart:math';
import 'package:charge_me/share/utils/constant/shared_preferences_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:auto_route/auto_route.dart' as autoRoute;
import '../core/application.dart';
import '../core/provider/theme_notifier.dart';
import '../core/router/custom_route_observer.dart';
import '../core/router/router.dart';
import '../core/service_locator.dart';
import '../core/styles/theme/dark_theme.dart';
import '../core/styles/theme/light_theme.dart';
import '../generated/l10n.dart';
import 'bloc/app_bloc/app_bloc.dart';
import 'package:provider/provider.dart';

const maxPossibleTsf = 1.0;

class CustomMaterialApp extends StatefulWidget {
  const CustomMaterialApp({super.key});

  @override
  State<CustomMaterialApp> createState() => _CustomMaterialAppState();
}

class _CustomMaterialAppState extends State<CustomMaterialApp> {
  bool _initialized = false;
  late AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc();
    Application.tokenChangeHandler = _appTokenChanged;
    Application.onAppLanguageChanged = _appLanguageChanged;
    startApplication().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  void dispose() {
    _appBloc.close();
    super.dispose();
  }

  void _appLanguageChanged(String? language) async {
    Application.language = language ?? 'ru';
    await Application.sharedPreferences
        ?.setString(SharedPreferencesKeys.appLanguage, language ?? 'ru');
    setState(() {});
  }

  void _appTokenChanged(String? token) async {
    Application.token = token;
    await Application.sharedPreferences
        ?.setString(SharedPreferencesKeys.token, token!);
    setState(() {});
  }

  Future<void> startApplication() async {
    await Application.setupSharedPreferences();
    await Application.setLanguageFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Container();
    }
    final router = ServiceLocator.get<AppRouter>();
    return MultiProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (BuildContext context) => _appBloc,
        ),
        ChangeNotifierProvider(
            create: (_) => ThemeNotifier(
                themeModeType: true ? ThemeMode.light : ThemeMode.dark,
                Locale(Application.language ?? 'ru'))),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
        return MaterialApp.router(
          builder: (context, child) {
            final data = MediaQuery.of(context);
            final newTextScaleFactor =
                min(maxPossibleTsf, data.textScaleFactor);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: newTextScaleFactor,
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.defaultRouteParser(),
          routerDelegate: autoRoute.AutoRouterDelegate(router,
              navigatorObservers: () => [CustomRouteObserver()]),
          title: '',
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],
          locale: themeNotifier.appLocal,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          theme: DarkTheme.darkThemeData(context),
          darkTheme: DarkTheme.darkThemeData(context),
          themeMode: themeNotifier.themeMode,
        );
      }),
    );
  }
}
