import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xff9D36F8);
  static const Color secondaryColor = Color(0xFFFAE591);
  static const Color statusBarColor = Colors.transparent;
  static const Color primary = Color(0xff3156a2);
  static const Color primaryButton = Color(0xff9D36F8);
  static Color blackGrey = const Color.fromARGB(255, 39, 39, 39);
  static Color backgroundBlack = const Color.fromARGB(255, 37, 37, 37);
  static Color backgroundWhite = const Color.fromARGB(255, 255, 255, 255);
  static Color backgroundGray = const Color.fromARGB(255, 240, 240, 240);
  static Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkStyle = Color(0xFF263238);

  static const List<Color> gradient = [
    Color.fromRGBO(25, 118, 210, 1),
    Color.fromRGBO(30, 136, 229, 0.9),
    Color.fromRGBO(33, 150, 243, 0.8),
    Color.fromRGBO(66, 165, 245, 0.7),
    Color.fromRGBO(100, 181, 246, 0.6),
    Color.fromRGBO(144, 202, 249, 0.5),
    Color.fromRGBO(187, 222, 251, 0.4),
    Color.fromRGBO(227, 242, 253, 0.0),
  ];
  static const List<Color> gradientButton = [
    Color(0xFF21A5B5),
    Color(0xFF71B2B4),
  ];

  static const MaterialColor primarySwatch = MaterialColor(0xFF489E83, {
    50: Color(0xffce5641 ),//10%
    100: Color(0xffb74c3a),//20%
    200: Color(0xffa04332),//30%
    300: Color(0xff89392b),//40%
    400: Color(0xff733024),//50%
    500: Color(0xff5c261d),//60%
    600: Color(0xff451c16),//70%
    700: Color(0xff2e130e),//80%
    800: Color(0xff170907),//90%
    900: Color(0xff000000),//100%
  });
}
