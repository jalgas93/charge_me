import 'package:charge_me/core/application.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/base_repository.dart';

class AccountSetupRepository extends BaseRepository {
  Future<dynamic> address({
    required double latitude,
    required double longitude,
  }) async {
    var data = {
      "apikey": dotenv.env['YANDEX_GEOCODE'],
      "geocode": '$longitude,$latitude',
      "lang": Application.language,
      "format": 'json',
      "result": '1',
    };
    final response = await client.get(
      'https://geocode-maps.yandex.ru/v1/',
      queryParameters: data,
    );
    return response.data;
  }

  Future<dynamic> addCar({
    required String manufacture,
    required String model,
    required String connector,
    required String makeYear,
    required String registrationNumber,
    required String batteryCapacity,
    required String plug,
    required int userId,
  }) async {
    var data = {
      "manufacture": manufacture,
      "model": model,
      "connector": connector,
      "makeYear": makeYear,
      "registrationNumber": registrationNumber,
      "batteryCapacity": batteryCapacity,
      "plug": plug,
      "userId": userId,
    };
    final response = await client.post(
      'api/v1/car/add',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> addLocation({
    required double latitude,
    required double longitude,
    String? country,
    String? county,
    String? city,
    String? road,
    String? town,
    required int userId,
  }) async {
    var data = {
      "latitude": latitude,
      "longitude": longitude,
      "county": county,
      "country": country,
      "city": city,
      "road": road,
      "town": town,
      "userId": userId,
    };
    final response = await client.post(
      'api/v1/userLocation/add',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> userUpdate({
    String? avatar,
    String? firstname,
    String? role,
    required int userId,
  }) async {
    var data = {"avatar": avatar, "firstname": firstname, "role": role};
    final response = await client.put(
      'api/v1/users/update/$userId',
      data: data,
    );
    return response.data;
  }
}
