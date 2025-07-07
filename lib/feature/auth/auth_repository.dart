import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/base_repository.dart';

class AuthRepository extends BaseRepository {

  Future<dynamic> registerByTelegram({
    required String phone,
    required String password,
    String role = "USER",
    String? createAt,
  }) async {
    var data = {
      "phone": phone,
      "password": password,
      "role": role,
      "createAt": createAt,
    };
    final response = await client.post(
      'api/v1/auth/tg',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> registerByPhone({
    required String phone,
    required String password,
    String role = "USER",
    String? createAt,
  }) async {
    var data = {
      "phone": phone,
      "password": password,
      "role": role,
      "createAt": createAt,
    };
    final response = await client.post(
      'api/v1/auth/registration',
      data: data,
    );
    return response.data;
  }
  Future<dynamic> registerVerifyTelegram({
    required String requestId,
    required String code,
  }) async {
    var data = {
      "request_id": requestId,
      "code": code,
    };
    final response = await client.post(
      'api/v1/auth/verify',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    var data = {
      "phone": phone,
      "password": password,
    };
    final response = await client.post(
      'api/v1/auth/sign-in',
      data: data,
    );
    return response.data;
  }
  Future<dynamic> resendOtpTg({
    required String phone,
  }) async {
    var data = {
      "phone": phone,
    };
    final response = await client.post(
      'api/v1/auth/resendOtp',
      data: data,
    );
    return response.data;
  }
}
