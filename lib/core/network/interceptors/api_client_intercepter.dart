import 'package:dio/dio.dart';

import '../../../share/utils/constant/config_app.dart';
import '../../../share/utils/flutter_secure_storage.dart';
import '../response/api_exception.dart';
import '../response/api_response.dart';


class ApiClientInterceptor extends Interceptor {
  final Dio client;

  ApiClientInterceptor({required this.client});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ConfigApp.url;
    options.responseType = ResponseType.json;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final apiResponse = ApiResponse.fromJson(response.data);
    if (!apiResponse.isSuccess) {
      throw ApiException.fromJson(response.data);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null && [401].contains(err.response?.statusCode)) {
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
  var response = await client.post('api/v1/auth/refresh', data: refreshToken);
  if (response.statusCode == 200) {
    return response.data['data']['token'];
  }
  return response.data['data']['token'];
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
