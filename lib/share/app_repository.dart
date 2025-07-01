import 'package:charge_me/core/base_repository.dart';

class AppRepository extends BaseRepository {
  Future<dynamic> userSettings({
    required int userId,
  }) async {
    final response =
        await client.get('api/v1/settings/$userId');
    return response.data;
  }
}
