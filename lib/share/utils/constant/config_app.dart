import 'package:flutter/foundation.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static const String _url = "http://localhost:8080/api/v1/";

  static String get url => _url;
}
