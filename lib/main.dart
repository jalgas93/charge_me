import 'package:charge_me/share/custom_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/logging/log.dart';
import 'core/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await ServiceLocator.setup();
  Log.initialize();
  runApp(const CustomMaterialApp());
}
