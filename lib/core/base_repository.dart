import 'package:charge_me/core/service_locator.dart';

import 'network/http/api_client.dart';

abstract class BaseRepository {
  late ApiClient client;

  BaseRepository() {
    client = ServiceLocator.get<ApiClient>();
  }
}
