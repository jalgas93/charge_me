import 'dart:convert';

class ApiResponse {
  final String? type;
  final bool? success;
  final int? errorCode;
  final String? errMessage;
  final dynamic data;
  final dynamic response;

  ApiResponse({this.type,required this.success,this.errorCode, this.data, this.errMessage, this.response});

  factory ApiResponse.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    return ApiResponse(
      type: json['type'],
      success: json['success'],
      errorCode: json['errorCode'],
      errMessage: json['errMessage'],
      data: json['data'],
      response: json,
    );
  }

  bool get isSuccess => errorCode == null;

  bool get isError => !isSuccess;
}
