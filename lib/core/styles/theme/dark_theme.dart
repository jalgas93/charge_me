import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';
import '../app_text_style.dart';

class DarkTheme {
  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.primaryDarkColor,
      primaryColor: AppColors.primaryDarkColor,

      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          background: const Color(0xFF455A64),
          seedColor: const Color(0xFF37474F),
          primary: AppColors.focusColor,
          secondary: Colors.tealAccent,
          surface: AppColors.primaryDarkColor,
          onBackground: AppColors.primaryDarkColor,
          onSurface: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.black,
          onSecondary: Colors.yellow,
          error: Colors.red.shade400),

      hoverColor: const Color(0xFF00ACC1),

      drawerTheme: const DrawerThemeData(),
      focusColor: AppColors.focusColor,
      unselectedWidgetColor: AppColors.unselectColor,

      ///SwitchTheme
      switchTheme: SwitchThemeData(
        splashRadius: 15,
        trackOutlineColor: MaterialStateProperty.all(Colors.white),
        thumbColor: MaterialStateProperty.all(Colors.green),
        trackColor: MaterialStateProperty.all(Colors.transparent),
      ),

      sliderTheme: const SliderThemeData(
        inactiveTrackColor: Colors.white,
      ),

      /// Card Theme
      cardTheme: const CardTheme(
          color: Color(0xFF1F2E35),
          margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          shadowColor: Colors.greenAccent,
          elevation: 5,
          surfaceTintColor: Colors.white),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.primaryDarkColor,
      ),

      ///AppBar theme
      appBarTheme: const AppBarTheme(
          //color: Colors.black,
          shadowColor: Colors.black,
          elevation: 5,
          iconTheme: IconThemeData(),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black),
          foregroundColor: Colors.black),

      /// Icon theme
      iconTheme: const IconThemeData(
          color: Colors.white,
          /*       shadows: [
            BoxShadow(
                color: Colors.green,
                blurRadius: 2.0,
                offset: Offset(1, 1),
                blurStyle: BlurStyle.outer
            ),
          ],*/
          fill: 0.0,
          opacity: 1.0,
          // size: 40,
          weight: 100,
          opticalSize: 20,

          /// Optical sizes range from 20dp to 48dp. we can maintain
          /// the stroke width common while resizing or on increase of the icon size
          grade:
              0 // (For light and dart themes) To make strokes heavier and more emphasized, use positive value grade, such as when representing an active icon state.
          ),

      ///SnackBar theme
      snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.apply(color: Theme.of(context).cardColor)),
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: TextTheme(
        displayLarge:
            AppTextStyle.displayLarge.copyWith(color: AppColors.white),
        displayMedium:
            AppTextStyle.displayMedium.copyWith(color: AppColors.white),
        displaySmall:
            AppTextStyle.displaySmall.copyWith(color: AppColors.white),
        headlineLarge:
            AppTextStyle.headlineLarge.copyWith(color: AppColors.white),
        headlineMedium:
            AppTextStyle.headlineMedium.copyWith(color: AppColors.white),
        headlineSmall:
            AppTextStyle.headlineSmall.copyWith(color: AppColors.white),
        titleLarge: AppTextStyle.titleLarge.copyWith(color: AppColors.white),
        titleMedium: AppTextStyle.titleMedium.copyWith(color: AppColors.white),
        titleSmall: AppTextStyle.titleMedium.copyWith(color: AppColors.white),
        labelLarge: AppTextStyle.labelLarge.copyWith(color: AppColors.white),
        labelMedium: AppTextStyle.labelMedium.copyWith(color: AppColors.white),
        labelSmall: AppTextStyle.labelSmall.copyWith(color: AppColors.white),
        bodyLarge: AppTextStyle.bodyLarge.copyWith(color: AppColors.white),
        bodyMedium: AppTextStyle.bodyMedium.copyWith(color: AppColors.white),
        bodySmall: AppTextStyle.bodySmall.copyWith(color: AppColors.white),
      ),

      dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(fontWeight: FontWeight.w100)),
      useMaterial3: true,
    );
  }
}
