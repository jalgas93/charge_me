import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/auth/model/sign_in/sign_in_model.dart';
import 'package:charge_me/feature/auth/model/telegram_register/telegram_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../core/application.dart';
import '../../../core/utils/constant/shared_preferences_keys.dart';
import '../../../core/utils/flutter_secure_storage.dart';
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
            final response = await _repository.registerByPhone(
                phone: event.phone,
                password: event.password,
                createAt: DateFormat('dd.MM.yyyy').format(DateTime.now()));
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
            final response = await _repository.loginWithPhone(
                phone: event.phone, password: event.password);
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
                phone: event.phone, password: event.password);

            emit(AuthState.successRegisterWithTelegram(
                telegramStatus: TelegramStatus.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        verifyRegisterTelegram: (event) async {
          emit(const AuthState.loading());
          try {
            await _repository.registerVerifyTelegram(
                requestId: event.requestId, code: event.code);

            emit(const AuthState.successVerifyRegisterTelegram());
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        });
  }
}
