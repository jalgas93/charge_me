import 'package:flutter/foundation.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static const String _urlImageEditing = "";

  static String get urlImageEditing => _urlImageEditing;
}
