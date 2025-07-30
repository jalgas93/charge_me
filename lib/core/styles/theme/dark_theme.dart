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
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColorsDark.green2,
        onPrimary: AppColorsDark.black,
        primaryContainer: AppColorsDark.white3,
        secondary: AppColorsDark.green2,
        onSecondary: AppColorsDark.black,
        surface: AppColorsDark.white3,
        onSurface: AppColorsDark.white,
        background: AppColorsDark.white4,
        onBackground: AppColorsDark.white,
        error: AppColorsDark.red2,
        onError: AppColorsDark.white,
        surfaceVariant: AppColorsDark.white4,
        outline: AppColorsDark.green2,
        outlineVariant: AppColorsDark.green1,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        color: AppColorsDark.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColorsDark.white),
        titleTextStyle: AppTextStyle.headlineMedium.copyWith(
          color: AppColorsDark.white,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColorsDark.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyle.displayLarge.copyWith(color: AppColorsDark.white),
        displayMedium: AppTextStyle.displayMedium.copyWith(color: AppColorsDark.white),
        displaySmall: AppTextStyle.displaySmall.copyWith(color: AppColorsDark.white),
        headlineLarge: AppTextStyle.headlineLarge.copyWith(color: AppColorsDark.white),
        headlineMedium: AppTextStyle.headlineMedium.copyWith(color: AppColorsDark.white),
        headlineSmall: AppTextStyle.headlineSmall.copyWith(color: AppColorsDark.white),
        titleLarge: AppTextStyle.titleLarge.copyWith(color: AppColorsDark.white),
        titleMedium: AppTextStyle.titleMedium.copyWith(color: AppColorsDark.white),
        titleSmall: AppTextStyle.titleMedium.copyWith(color: AppColorsDark.white),
        labelLarge: AppTextStyle.labelLarge.copyWith(color: AppColorsDark.white),
        labelMedium: AppTextStyle.labelMedium.copyWith(color: AppColorsDark.white),
        labelSmall: AppTextStyle.labelSmall.copyWith(color: AppColorsDark.white),
        bodyLarge: AppTextStyle.bodyLarge.copyWith(color: AppColorsDark.bodyText),
        bodyMedium: AppTextStyle.bodyMedium.copyWith(color: AppColorsDark.bodyText),
        bodySmall: AppTextStyle.bodySmall.copyWith(color: AppColorsDark.bodyText),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.green2,
          foregroundColor: AppColorsDark.black,
          textStyle: AppTextStyle.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColorsDark.white5,
        margin: const EdgeInsets.all(8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        surfaceTintColor: Colors.transparent,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.white4,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColorsDark.bodyText.withOpacity(0.6),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColorsDark.yellow1,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColorsDark.divider.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColorsDark.green2;
          }
          return AppColorsDark.white;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColorsDark.green2.withOpacity(0.5);
          }
          return AppColorsDark.white3;
        }),
        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        splashRadius: 15,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColorsDark.green2;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColorsDark.black),
        side: const BorderSide(color: AppColorsDark.green1, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColorsDark.green2,
        inactiveTrackColor: AppColorsDark.white3,
        thumbColor: AppColorsDark.green2,
        overlayColor: AppColorsDark.green2.withOpacity(0.2),
        valueIndicatorColor: AppColorsDark.green2,
        activeTickMarkColor: AppColorsDark.white,
        inactiveTickMarkColor: AppColorsDark.white3,
      ),

      // Bottom App Bar Theme
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColorsDark.primary,
        elevation: 0,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColorsDark.green2,
        foregroundColor: AppColorsDark.black,
        elevation: 4,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColorsDark.green2,
        unselectedLabelColor: AppColorsDark.bodyText,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColorsDark.green2,
            width: 2,
          ),
        ),
      ),
    );
  }
}