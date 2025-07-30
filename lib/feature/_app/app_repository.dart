import 'package:charge_me/core/base_repository.dart';
import 'package:charge_me/core/utils/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class AppRepository extends BaseRepository {
  Future<dynamic> userSettings({
    required int userId,
  }) async {
    final response = await client.get('api/v1/settings/$userId');
    return response.data;
  }

  Future<dynamic> refreshToken() async {
    var accessToken = await SecureStorageService.getInstance.getValue("access_token");
    final refreshToken =
        await SecureStorageService.getInstance.getValue("refresh_token");
    var data = {"refreshToken": refreshToken};
    var response = await client.post(
      'api/v1/auth/refresh',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return response.data;
  }
}
