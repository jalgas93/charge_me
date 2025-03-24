import 'dart:convert';

import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int? errorCode;
  final String? errMessage;
  final DioError? dioError;

  final bool apiError;
  final bool statusError;
  final int? responseStatus;

  ApiException({
    this.errorCode,
    this.errMessage,
    this.dioError,
    this.apiError = false,
    this.statusError = false,
    this.responseStatus,
  });

  factory ApiException.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    return ApiException(
      errorCode: json['errorCode'],
      errMessage: json['errMessage'],
      apiError: true,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errMessage'] = errMessage;
    data['apiError'] = apiError;
    data['statusError'] = statusError;
    data['responseStatus'] = responseStatus;
    return data;
  }

  @override
  String toString() => errMessage ?? '';

  String get message => errMessage!;
}
