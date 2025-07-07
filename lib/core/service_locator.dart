import 'package:charge_me/core/network/http/websocket_new.dart';
import 'package:charge_me/core/router/router.dart';
import 'package:get_it/get_it.dart';
import 'network/http/api_client.dart';
import 'network/http/websocket_client.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    getIt.registerSingleton<ApiClient>(ApiClient.instance());
    getIt.registerSingleton<WebSocketService>(WebSocketService());
    getIt.registerSingleton<AppRouter>(AppRouter());
    //getIt.registerSingleton<Cache>(await Cache.instance());
  }

/*  static void dispose() {
    ServiceLocator.get<Cache>().dispose();
  }*/

  static bool isRegistered<T extends Object>() {
    return getIt.isRegistered<T>();
  }

  static void unregister<T extends Object>() {
    if (getIt.isRegistered<T>()) {
      getIt.unregister<T>();
    }
  }

  static void registerSingleton<T extends Object>(T service) {
    if (!isRegistered<T>()) getIt.registerSingleton<T>(service);
  }

  static T get<T extends Object>() {
    return getIt<T>();
  }
}
