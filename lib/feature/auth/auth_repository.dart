import '../../core/base_repository.dart';

class AuthRepository extends BaseRepository {
  Future<dynamic> registerByUsername({
    required String username,
    required String phone,
    required String password,
    required String firstname,
    required String avatar,
    String role = "USER",
    String? createAt,
  }) async {
    var data = {
      "username": username,
      "phone": phone,
      "password": password,
      "firstname": firstname,
      "avatar": avatar,
      "role": role,
      "createAt": "Today",
    };
    final response = await client.post(
      'api/v1/auth/registration',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> loginWithUsername({
    required String username,
    required String password,
  }) async {
    var data = {
      "username": username,
      "password": password,
    };
    final response = await client.post(
      'api/v1/auth/sign-in',
      data: data,
    );
    return response.data;
  }
}
