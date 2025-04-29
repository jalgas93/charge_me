part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const  factory AuthState.error({required dynamic error}) = _Error;
  const factory AuthState.successRegisterWithUsername({required RegisterModel registerModel}) = _SuccessRegisterWithUsername;
  const factory AuthState.successLoginWithUsername({required SignInModel signInModel}) = _SuccessLoginWithUsername;
}
