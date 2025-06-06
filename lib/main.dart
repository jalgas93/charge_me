import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';
import 'package:charge_me/share/custom_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/assertions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/logging/log.dart';
import 'core/router/router.dart';
import 'core/service_locator.dart';

final router = ServiceLocator.get<AppRouter>();

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
/*  FlutterError.onError = (FlutterErrorDetails details) async {
    Log.i('GREY SCREEN', details);
    router.push(const SplashPageRoute());
  };*/
/*  runZoned<Future<void>>(() async {

  }, onError: (error, stackTrace) {
    Log.i(error, stackTrace);
  });*/

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //debugRepaintRainbowEnabled = true;
  await ServiceLocator.setup();
  Log.initialize();
  runApp(const CustomMaterialApp());
}
