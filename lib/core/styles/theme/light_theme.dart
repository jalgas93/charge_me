import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors_dark.dart';
import '../app_fonts.dart';

class LightTheme{
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Inter',
     // scaffoldBackgroundColor: AppColorsDark.white,
     // primaryColor: AppColorsDark.primaryLightColor,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.orange,
          primaryContainer: Colors.white,
          secondary: Colors.white,
          secondaryContainer: Colors.white,
          background: Colors.white,
          surface: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.grey,
          onSecondary: Colors.white,
          error: Colors.red.shade400),

 /*     hoverColor: Colors.green.shade200,

      //dividerColor: AppColorsDark.primaryDarkColor,

      focusColor: Colors.green.shade800,

      radioTheme:const RadioThemeData(
        //overlayColor: WidgetStatePropertyAll<Color?>(Colors.grey),
        fillColor:WidgetStatePropertyAll<Color?>(Colors.green),
      ),
      dialogTheme: const DialogTheme(iconColor: Colors.orange),
      /// Icon theme
      iconTheme: const IconThemeData(
          color: Colors.orange,
          shadows: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                offset: Offset(1, 1),
                blurStyle: BlurStyle.outer),
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

      sliderTheme:SliderThemeData(
        inactiveTrackColor: Colors.grey.shade300,
        activeTrackColor: Colors.orange,
        thumbColor: Colors.orange,
      ) ,
      /// Card Theme
      cardTheme: CardTheme(
          color: const Color(0xFFF5F4F8),
          margin: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
          shadowColor: Colors.grey.shade400,
          elevation: 5,
          surfaceTintColor: Colors.grey),

      appBarTheme: AppBarTheme(
        color: Colors.green.shade200,
        shadowColor: Colors.white,
        elevation: 5,
        foregroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
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
          elevation: 5),*/
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

 /*     ///SwitchTheme
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
          textStyle: TextStyle(fontWeight: FontWeight.w100)),*/

      useMaterial3: true,
    );
  }
}