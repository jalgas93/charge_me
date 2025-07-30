import 'package:dio/dio.dart';

import '../../../feature/_app/utils/flutter_secure_storage.dart';
import '../../../feature/account/model/user_model/user_model.dart';
import '../../utils/constant/config_app.dart';
import '../../logging/log.dart';
import '../response/api_exception.dart';
import '../response/api_response.dart';

class ApiClientInterceptor extends Interceptor {
  final Dio client;

  ApiClientInterceptor({required this.client});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken =
        await SecureStorageService.getInstance.getValue("access_token");
    options.baseUrl = ConfigApp.localHost;
    options.responseType = ResponseType.json;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    if (const UserModel().userId != null) {
      options.headers['user_id'] = const UserModel().userId;
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('response ${response}');
    final apiResponse = ApiResponse.fromJson(response.data);
    if (!apiResponse.isSuccess) {
      throw ApiException.fromJson(response.data);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null && [401, 403].contains(err.response?.statusCode)) {
      final newAccessToken = await refreshToken(client);
      SecureStorageService.getInstance.setValue("access_token", newAccessToken);
      try {
        handler.resolve(await _retry(err.requestOptions, client));
      } on DioError catch (e) {
        handler.next(e);
      }
      return;
    }
    handler.next(err);
  }
}

Future<String> refreshToken(Dio client) async {
  final refreshToken =
      await SecureStorageService.getInstance.getValue("refresh_token");
  var data = {"refreshToken": refreshToken};
  var response = await client.post('api/v1/auth/refresh',
      data: data,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ));

  return response.data['data']['accessToken'];
}

Future<Response<dynamic>> _retry(
    RequestOptions requestOptions, Dio client) async {
  final accessToken =
      await SecureStorageService.getInstance.getValue("access_token");
  final options = Options(
    method: requestOptions.method,
    headers: {
      "Authorization": "Bearer $accessToken",
    },
  );

  return client.request<dynamic>(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options);
}
