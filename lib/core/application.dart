import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../share/utils/constant/shared_preferences_keys.dart';


typedef LanguageChangeHandler = Function(String language);
typedef DashboardTabChangeHandler = Function(
  int tabIndex, [
  bool discardCardId,
]);

class Application {
  static String? language;
  static String? theme;
  static String? token;
  static LanguageChangeHandler? onAppLanguageChanged;
  static LanguageChangeHandler? onAppThemeChanged;
  static LanguageChangeHandler? tokenChangeHandler;


  Application._();

  // Shared Prefs
  static SharedPreferences? get sharedPreferences => _sharedPreferences;
  static SharedPreferences? _sharedPreferences;
  static ValueNotifier<int> notificationsCountNotifier = ValueNotifier(0);

  static Future<void> setupSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLanguageFromSharedPrefs() async {
    bool? issetKey =
        sharedPreferences?.containsKey(SharedPreferencesKeys.appLanguage);
    bool? tokenKey =
    sharedPreferences?.containsKey(SharedPreferencesKeys.token);

    if (language == null && issetKey != null && issetKey) {
      language =
          sharedPreferences?.getString(SharedPreferencesKeys.appLanguage);
    }
    if (token == null && tokenKey != null && tokenKey) {
      token = sharedPreferences?.getString(SharedPreferencesKeys.token);
    }
  }
  static DashboardTabChangeHandler? dashboardTabChangeCallback;

  static void changeDashboardTab(
    int index, {
    bool discardCardId = true,
  }) {
    dashboardTabChangeCallback?.call(index, discardCardId);
  }

  static set notificationCount(int value) {
    notificationsCountNotifier.value = value;
  }
}
