part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;

  const factory AuthEvent.registerWithUsername({
    required String username,
    required String phone,
    required String password,
    required String firstname,
    required String avatar,
    String? role,
  }) = _RegisterWithUsername;

  const factory AuthEvent.loginWithUsername({
    required String username,
    required String password,
  }) = _LoginWithUsername;
}
