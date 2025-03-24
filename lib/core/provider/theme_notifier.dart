import 'package:flutter/material.dart';

import '../application.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeNotifier(Locale local,{this.themeModeType}):_appLocale = local;

  ThemeMode? themeModeType = ThemeMode.system;
  ThemeMode? get themeMode => themeModeType;
  Locale _appLocale;
  Locale get appLocal => _appLocale;

  void setTheme(ThemeMode? mode) {
    themeModeType = mode;
    Application.onAppThemeChanged
        ?.call(themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }
  void changeLanguage(String locale) async {
    _appLocale = Locale(locale);
    Application.onAppLanguageChanged
        ?.call(locale ?? 'en');
    notifyListeners();
  }

  bool get isLightTheme =>
      themeMode == ThemeMode.light || themeMode == ThemeMode.system;
  bool get isDarkTheme =>
      themeMode == ThemeMode.dark || themeMode == ThemeMode.system;
}