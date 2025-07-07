part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;

  const factory AuthEvent.registerWithPhone({
    required String phone,
    required String password,
  }) = _RegisterWithPhone;

  const factory AuthEvent.registerWithTelegram({
    required String phone,
    required String password,
  }) = _RegisterWithTelegram;

  const factory AuthEvent.loginWithPhone({
    required String phone,
    required String password,
  }) = _LoginWithPhone;

  const factory AuthEvent.verifyRegisterTelegram({
    required String code,
    required String requestId,
  }) = _VerifyRegisterTelegram;
  const factory AuthEvent.resendOtpTelegram({
    required String phone,
  }) = _ResendOtpTelegram;
}
