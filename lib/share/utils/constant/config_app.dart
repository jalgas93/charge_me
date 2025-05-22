import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static  String apiBaseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String apiDevUrl = 'https://dev.tazaquat.kz/';

  static String get url => apiBaseUrl;
}
