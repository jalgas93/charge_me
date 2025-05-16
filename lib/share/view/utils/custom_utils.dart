import 'package:flutter/material.dart';

enum Language { en, ru, uz, cn, kg, tj }

class CustomUtils {
  static final ValueNotifier<Language> _language = ValueNotifier(Language.ru);

  static set setLanguage(Language value) {
    _language.value = value;
  }

  static ValueNotifier<Language> get language => _language;
}
