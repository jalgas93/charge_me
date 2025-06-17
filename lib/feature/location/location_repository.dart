import '../../core/base_repository.dart';

class LocationRepository extends BaseRepository {
  Future<dynamic> getStations() async {
    final response = await client.get('api/v1/station/findAll');
    return response.data;
  }
}
