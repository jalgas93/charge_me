import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/base_repository.dart';

class AccountSetupRepository extends BaseRepository {

  Future<dynamic> address({
    required double latitude,
    required double longitude,
    required String lang,
  }) async {
    var data = {
      "apikey": dotenv.env['YANDEX_GEOCODE'],
      "geocode": '69.331843,41.305912',
      "lang": lang,
      "format": 'json',
      "result": '1',
    };
    final response = await client.get(
      'https://geocode-maps.yandex.ru/v1/',
      queryParameters: data,
    );
    return response.data;
  }

}