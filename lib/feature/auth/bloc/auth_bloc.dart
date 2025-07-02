import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/auth/model/sign_in/sign_in_model.dart';
import 'package:charge_me/feature/auth/model/tg/sms_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../core/application.dart';
import '../../../core/helpers/app_user.dart';
import '../../../core/logging/log.dart';
import '../../../core/utils/constant/shared_preferences_keys.dart';
import '../../../core/utils/flutter_secure_storage.dart';
import '../../account/model/user_model/user_model.dart';
import '../auth_repository.dart';
import '../model/register/register_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) => _auth(event, emit));
  }

  Future<void> _auth(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await event.map(
        started: (event) async {},
        registerWithPhone: (event) async {
          emit(const AuthState.loading());
          try {
            final dynamic response = await _repository.registerByPhone(
                phone: event.phone,
                password: event.password,
                createAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
            AppUser.setUserModel = UserModel.fromJson(response['data']);
            await SecureStorageService.getInstance
                .setValue("access_token", response['data']['accessToken']);
            await SecureStorageService.getInstance
                .setValue("refresh_token", response['data']['refreshToken']);
            emit(AuthState.successRegisterWithPhone(
                registerModel: RegisterModel.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        loginWithPhone: (event) async {
          emit(const AuthState.loading());
          try {
            final dynamic response = await _repository.loginWithPhone(
                phone: event.phone, password: event.password);

            print('response ${response['data']}');
            print('access_token ${response['data']['accessToken']}');
            print('refresh_token ${response['data']['refreshToken']}');
            AppUser.setUserModel = UserModel.fromJson(response['data']);
            await SecureStorageService.getInstance
                .setValue("access_token", response['data']['accessToken']);
            await SecureStorageService.getInstance
                .setValue("refresh_token", response['data']['refreshToken']);
            emit(AuthState.successLoginWithPhone(
                signInModel: SignInModel.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        registerWithTelegram: (event) async {
          emit(const AuthState.loading());
          try {
            final response = await _repository.registerByTelegram(
                phone: event.phone,
                password: event.password,
                createAt: DateFormat('dd.MM.yyyy').format(DateTime.now()));
            emit(AuthState.successTelegramState(
                model: SmsResponse.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        verifyRegisterTelegram: (event) async {
          emit(const AuthState.loading());
          try {
            final dynamic response = await _repository.registerVerifyTelegram(
                requestId: event.requestId, code: event.code);
            Log.i("verifyRegisterTelegram", response);
            AppUser.setUserModel = UserModel.fromJson(response);
            await SecureStorageService.getInstance
                .setValue("access_token", response['data']['accessToken']);
            await SecureStorageService.getInstance
                .setValue("refresh_token", response['data']['refreshToken']);
            emit(const AuthState.successVerifyRegisterTelegram());
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        resendOtpTelegram: (event) async {
          emit(const AuthState.loading());
          try {
           final response =  await _repository.resendOtpTg(phone: event.phone);

           emit(AuthState.successResendOtpTelegram(
               model: SmsResponse.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        });
  }
}
