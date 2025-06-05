import 'dart:convert';

import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String? message;

  ApiException({
    this.statusCode,
    this.message,
  });

  factory ApiException.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    return ApiException(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }

  @override
  String toString() => message ?? '';

  String get messageA => message!;
}
