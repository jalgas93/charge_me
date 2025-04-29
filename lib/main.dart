import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/share/custom_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/assertions.dart';

import 'core/logging/log.dart';
import 'core/router/router.dart';
import 'core/service_locator.dart';

final router = ServiceLocator.get<AppRouter>();

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Log.i('GREY SCREEN', details);
    router.push(const SplashPageRoute());
  };
  runZoned<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    //debugRepaintRainbowEnabled = true;
    await ServiceLocator.setup();
    Log.initialize();
    runApp(const CustomMaterialApp());
  }, onError: (error, stackTrace) {
    Log.i(error, stackTrace);
  });
}
