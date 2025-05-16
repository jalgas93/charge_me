import 'package:flutter/foundation.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static const String apiBaseUrl = 'https://prod.tazaquat.kz/';
  static const String apiDevUrl = 'https://dev.tazaquat.kz/';

  static String get url => apiBaseUrl;
}
