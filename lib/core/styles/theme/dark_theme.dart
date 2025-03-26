import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors_dark.dart';
import '../app_fonts.dart';

class DarkTheme {
  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColorsDark.primary,

      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColorsDark.yellow1,
        primary: AppColorsDark.black,
        onPrimary: AppColorsDark.onPrimary,
        primaryContainer: AppColorsDark.primaryContainer,
        secondary: AppColorsDark.secondary,
        onSecondary: AppColorsDark.onSecondary,
        surface: AppColorsDark.surface,
        onSurface: AppColorsDark.onSurface,
        background: AppColorsDark.background,
        onBackground: AppColorsDark.onBackground,
        error: AppColorsDark.error,
        onError: AppColorsDark.onError,
        tertiary: AppColorsDark.tertiary,
        outline: AppColorsDark.green2,
        outlineVariant: AppColorsDark.green1
      ),

      drawerTheme: const DrawerThemeData(),

      dividerTheme: DividerThemeData(
        color:  AppColorsDark.divider.withOpacity(0.2)
      ),

      focusColor: AppColorsDark.green1,

      ///SwitchTheme
      switchTheme: SwitchThemeData(
        splashRadius: 15,
        trackOutlineColor: MaterialStateProperty.all(Colors.white),
        thumbColor: MaterialStateProperty.all(Colors.green),
        trackColor: MaterialStateProperty.all(Colors.transparent),
      ),

      sliderTheme: const SliderThemeData(
        inactiveTrackColor: AppColorsDark.white,
      ),

      /// Card Theme
      cardTheme: const CardTheme(
          color: AppColorsDark.white5,
          margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          elevation: 5,
          surfaceTintColor: Colors.white),

      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColorsDark.transparent,
      ),

      ///AppBar theme
      appBarTheme: const AppBarTheme(
          color: AppColorsDark.primary,
          shadowColor: Colors.transparent,
          //elevation: 5,
          iconTheme: IconThemeData(),
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: AppColorsDark.black),
          foregroundColor: Colors.black),

      /// Icon theme
      iconTheme: const IconThemeData(
          color: AppColorsDark.yellow1,
          fill: 0.0,
          opacity: 1.0,
          weight: 100,
          opticalSize: 20,
          grade:
              0 // (For light and dart themes) To make strokes heavier and more emphasized, use positive value grade, such as when representing an active icon state.
          ),

      textTheme: TextTheme(
        displayLarge:
            AppTextStyle.displayLarge.copyWith(color: AppColorsDark.white),
        displayMedium:
            AppTextStyle.displayMedium.copyWith(color: AppColorsDark.white),
        displaySmall:
            AppTextStyle.displaySmall.copyWith(color: AppColorsDark.white),
        headlineLarge:
            AppTextStyle.headlineLarge.copyWith(color: AppColorsDark.white),
        headlineMedium:
            AppTextStyle.headlineMedium.copyWith(color: AppColorsDark.white),
        headlineSmall:
            AppTextStyle.headlineSmall.copyWith(color: AppColorsDark.white),
        titleLarge:
            AppTextStyle.titleLarge.copyWith(color: AppColorsDark.white),
        titleMedium:
            AppTextStyle.titleMedium.copyWith(color: AppColorsDark.white),
        titleSmall:
            AppTextStyle.titleMedium.copyWith(color: AppColorsDark.white),
        labelLarge:
            AppTextStyle.labelLarge.copyWith(color: AppColorsDark.white),
        labelMedium:
            AppTextStyle.labelMedium.copyWith(color: AppColorsDark.white),
        labelSmall:
            AppTextStyle.labelSmall.copyWith(color: AppColorsDark.white),
        bodyLarge: AppTextStyle.bodyLarge.copyWith(color: AppColorsDark.bodyText),
        bodyMedium:
            AppTextStyle.bodyMedium.copyWith(color: AppColorsDark.bodyText),
        bodySmall: AppTextStyle.bodySmall.copyWith(color: AppColorsDark.bodyText),
      ),

      useMaterial3: true,
    );
  }
}
