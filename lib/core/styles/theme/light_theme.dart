import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors_light.dart';
import '../app_fonts.dart';

class LightTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColorsLight.white4,
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColorsLight.green2,
        onPrimary: AppColorsLight.white,
        primaryContainer: AppColorsLight.white3,
        secondary: AppColorsLight.green2,
        onSecondary: AppColorsLight.white,
        surface: AppColorsLight.white4,
        onSurface: AppColorsLight.darkStyleText,
        background: AppColorsLight.white4,
        onBackground: AppColorsLight.darkStyleText,
        error: AppColorsLight.red2,
        onError: AppColorsLight.white,
        surfaceVariant: AppColorsLight.white3,
        outline: AppColorsLight.green2,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        color: AppColorsLight.white4,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColorsLight.darkStyleText),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColorsLight.darkStyleText,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColorsLight.white4,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyle.displayLarge.copyWith(color: AppColorsLight.darkStyleText),
        displayMedium: AppTextStyle.displayMedium.copyWith(color: AppColorsLight.darkStyleText),
        displaySmall: AppTextStyle.displaySmall.copyWith(color: AppColorsLight.darkStyleText),
        headlineLarge: AppTextStyle.headlineLarge.copyWith(color: AppColorsLight.darkStyleText),
        headlineMedium: AppTextStyle.headlineMedium.copyWith(color: AppColorsLight.darkStyleText),
        headlineSmall: AppTextStyle.headlineSmall.copyWith(color: AppColorsLight.darkStyleText),
        titleLarge: AppTextStyle.titleLarge.copyWith(color: AppColorsLight.darkStyleText),
        titleMedium: AppTextStyle.titleMedium.copyWith(color: AppColorsLight.darkStyleText),
        titleSmall: AppTextStyle.titleSmall.copyWith(color: AppColorsLight.darkStyleText),
        labelLarge: AppTextStyle.labelLarge.copyWith(color: AppColorsLight.darkStyleText),
        labelMedium: AppTextStyle.labelMedium.copyWith(color: AppColorsLight.darkStyleText),
        labelSmall: AppTextStyle.labelSmall.copyWith(color: AppColorsLight.darkStyleText),
        bodyLarge: AppTextStyle.bodyLarge.copyWith(color: AppColorsLight.darkStyleText),
        bodyMedium: AppTextStyle.bodyMedium.copyWith(color: AppColorsLight.darkStyleText),
        bodySmall: AppTextStyle.bodySmall.copyWith(color: AppColorsLight.darkStyleText),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColorsLight.white4,
        margin: const EdgeInsets.all(8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        surfaceTintColor: Colors.transparent,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.green2,
          foregroundColor: AppColorsLight.white,
          textStyle: AppTextStyle.labelLarge.copyWith(color: AppColorsLight.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.white3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColorsLight.darkStyleText.withOpacity(0.6),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColorsLight.darkStyleText,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColorsLight.darkStyleText.withOpacity(0.1),
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorsLight.white4,
        selectedItemColor: AppColorsLight.green2,
        unselectedItemColor: AppColorsLight.darkStyleText.withOpacity(0.6),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorsLight.green2,
        foregroundColor: AppColorsLight.white,
        elevation: 4,
      ),
    );
  }
}