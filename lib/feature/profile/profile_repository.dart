import '../../core/base_repository.dart';

class ProfileRepository extends BaseRepository {
  Future<dynamic> getUser({required int userId}) async {
    final response = await client.get('api/v1/users/$userId');
    return response.data;
  }
}
