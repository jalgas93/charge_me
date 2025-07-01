import 'package:charge_me/core/service_locator.dart';

import 'network/http/api_client.dart';
import 'network/http/websocket_new.dart';

abstract class BaseRepository {
  late ApiClient client;
  late WebSocketService webSocketService;

  BaseRepository() {
    client = ServiceLocator.get<ApiClient>();
    webSocketService = ServiceLocator.get<WebSocketService>();
  }
}
