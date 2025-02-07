import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      primaryColor: AppColors.primaryColor,
      primarySwatch: AppColors.primarySwatch,
      colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green.shade200,
              background: Colors.white ?? Colors.green.shade50) ??
          ColorScheme(
              brightness: Brightness.light,
              primary: Colors.green,
              primaryContainer: Colors.green,
              secondary: Colors.white,
              secondaryContainer: Colors.white,
              background: Colors.white,
              surface: Colors.green,
              onBackground: Colors.white,
              onSurface: Colors.white,
              onError: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.red.shade400),

      hoverColor: Colors.green.shade200,

      dividerColor: const Color(0xffC7C7CC),

      /// Icon theme
      iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
          shadows: [
    /*        BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                offset: Offset(1, 1),
                blurStyle: BlurStyle.outer),*/
          ],
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

      /// Card Theme
      cardTheme: CardTheme(
          color: const Color(0xffF5F5F5) ?? Colors.green.shade50,
          margin: const EdgeInsets.all(16),
          shadowColor: Colors.greenAccent,
          elevation: 5,
          surfaceTintColor: Colors.white),

      appBarTheme: const AppBarTheme(
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return 5.0;
                } else {
                  return 3.0;
                }
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.white;
                } else {
                  return Colors.green;
                }
              }),
              shadowColor:
                  WidgetStateProperty.all<Color>(Colors.lightGreenAccent),
              textStyle: WidgetStateProperty.all(
                  const TextStyle(fontWeight: FontWeight.w600)),
              foregroundColor:
                  WidgetStateProperty.resolveWith((Set<MaterialState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return Colors.green;
                } else {
                  return Colors.white;
                }
              }))),

      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              shadowColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
              foregroundColor: MaterialStateProperty.all(Colors.white))),

      navigationRailTheme: NavigationRailThemeData(
        elevation: 5,
        useIndicator: true,
        indicatorColor: Colors.orange.shade100,
        indicatorShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        // labelType: NavigationRailLabelType.selected,
        selectedIconTheme: const IconThemeData(
          color: Colors.deepPurpleAccent,
          weight: 100,
        ),
        selectedLabelTextStyle:
            const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle: const TextStyle(color: Colors.green),
      ),

      dialogTheme: const DialogTheme(iconColor: Colors.orange),

      snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.black,
          contentTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.apply(color: Colors.white)),

      bannerTheme: MaterialBannerThemeData(
          backgroundColor: Colors.red,
          contentTextStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.apply(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          leadingPadding: const EdgeInsets.all(0),
          elevation: 5),
      textTheme: TextTheme(
        displayLarge: AppTextStyle.displayLarge,
        displayMedium: AppTextStyle.displayMedium,
        displaySmall: AppTextStyle.displaySmall,
        headlineLarge: AppTextStyle.headlineLarge,
        headlineMedium: AppTextStyle.headlineMedium,
        headlineSmall: AppTextStyle.headlineSmall,
        titleLarge: AppTextStyle.titleLarge,
        titleMedium: AppTextStyle.titleMedium,
        titleSmall: AppTextStyle.titleMedium,
        labelLarge: AppTextStyle.labelLarge,
        labelMedium: AppTextStyle.labelMedium,
        labelSmall: AppTextStyle.labelSmall,
        bodyLarge: AppTextStyle.bodyLarge,
        bodyMedium: AppTextStyle.bodyMedium,
        bodySmall: AppTextStyle.bodySmall,
      ),

      ///SwitchTheme
      switchTheme: SwitchThemeData(
        splashRadius: 15,
        trackOutlineColor: MaterialStateProperty.all(Colors.orange),
        thumbColor: MaterialStateProperty.all(Colors.orange),
        trackColor: MaterialStateProperty.all(Colors.green.shade200),
      ),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        dataRowColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.green;
            } else {
              return Colors.white;
            }
          },
        ),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        dataTextStyle: const TextStyle(
          color: Colors.black,
        ),
        headingRowColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.green;
            } else {
              return Colors.blueAccent.withOpacity(0.5);
            }
          },
        ),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(fontWeight: FontWeight.w100)),

      useMaterial3: true,
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: const Color(0xFF263238),
      primaryColor: AppColors.primaryColor,
      primarySwatch: AppColors.primarySwatch,

      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          background: const Color(0xFF455A64),
          seedColor: const Color(0xFF37474F),
          primary: Colors.green,
          primaryContainer: Colors.green,
          secondary: Colors.white,
          secondaryContainer: Colors.white,
          surface: const Color(0xFF263238),
          onBackground: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: Colors.red.shade400),
      hoverColor: const Color(0xFF00ACC1),

      drawerTheme: const DrawerThemeData(),
      focusColor: Colors.green,
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
      cardTheme: CardTheme(
          color: Colors.black ?? Colors.green.shade50,
          margin: const EdgeInsets.all(16),
          shadowColor: Colors.greenAccent,
          elevation: 5,
          surfaceTintColor: Colors.white),

      ///AppBar theme
      appBarTheme: const AppBarTheme(
          color: Colors.black,
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
