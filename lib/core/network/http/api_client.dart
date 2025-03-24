import 'package:dio/dio.dart';

import '../../../share/utils/constant/config_app.dart';
import '../../../share/utils/flutter_secure_storage.dart';
import '../interceptors/custom_dio_interceptor.dart';
import '../interceptors/api_client_intercepter.dart';
import '../response/api_response.dart';


class ApiClient {
  final Dio client;

  ApiClient._({
    required this.client,
  });

  factory ApiClient.instance() {
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    );
    final dio = Dio(baseOptions);
    dio.interceptors.add(ApiClientInterceptor(client: dio));

    if (ConfigApp.enableHttpDebugMessages) {
      dio.interceptors.add(CustomDioInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }
    return ApiClient._(client: dio);
  }

  Future<dynamic> download(
    String urlPath,
    dynamic savePath, {
    Options? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.download(urlPath, savePath,
        options: options, data: data, queryParameters: queryParameters);
    return response.data;
  }

  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await client.get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return ApiResponse.fromJson(response.data);
  }

  Future<dynamic> post(
    String url, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await client.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<ApiResponse> put(
    String url, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await client.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse> delete(
    String url, {
    dynamic data = const {},
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await client.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return ApiResponse.fromJson(response.data);
  }

  Future<String> refreshToken(Dio client) async {
    final refreshToken =
        await SecureStorageService.getInstance.getValue("refresh_token");
    final data = {'refresh': refreshToken};
    final response = await client.post('token/refresh', data: data);
    return response.data['data']['token']['access'];
  }
}
