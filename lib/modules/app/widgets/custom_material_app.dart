import 'dart:math';
import 'package:charge_me/modules/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../helpers/custom_theme.dart';

const maxPossibleTsf = 1.0;

class CustomMaterialApp extends StatefulWidget {
  const CustomMaterialApp({super.key});

  @override
  State<CustomMaterialApp> createState() => _CustomMaterialAppState();
}

class _CustomMaterialAppState extends State<CustomMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final data = MediaQuery.of(context);
        final newTextScaleFactor = min(maxPossibleTsf, data.textScaleFactor);
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: newTextScaleFactor,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: CustomTheme.lightThemeData(context),
      darkTheme: CustomTheme.darkThemeData(context),
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.system,
    );
  }
}
