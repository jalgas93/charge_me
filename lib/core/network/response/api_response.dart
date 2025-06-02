import 'dart:convert';

class ApiResponse {
  final bool? success;
  final int? statusCode;
  final String? message;
  final dynamic data;
  final dynamic response;

  ApiResponse({required this.success,this.statusCode, this.data, this.message, this.response});

  factory ApiResponse.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    return ApiResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'],
      response: json,
    );
  }

  bool get isSuccess => statusCode != null;

  bool get isError => !isSuccess;
}
