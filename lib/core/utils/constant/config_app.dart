import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static String apiBaseUrl = dotenv.env['PROD_URL'] ?? '';
  static String apiDevUrl = dotenv.env['DEV_URL'] ?? '';
  static String apiPayment = dotenv.env['PAYMENT_URL'] ?? '';
/*  static String localHost = apiBaseUrl;
  static String websocket = apiBaseUrl;*/
 static String localHost = 'http://192.168.1.17:8080/';
  static String websocket = 'ws://192.168.1.17:8080/';
  // static String localHost = 'http://192.168.100.237:8080/';
  // static String websocket = 'ws://192.168.100.237:8080/';

}
