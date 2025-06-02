part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const  factory AuthState.error({required dynamic error}) = _Error;
  const factory AuthState.successRegisterWithPhone({required RegisterModel registerModel}) = _SuccessRegisterWithPhone;
  const factory AuthState.successLoginWithPhone({required SignInModel signInModel}) = _SuccessLoginWithPhone;
  const factory AuthState.successVerifyRegisterTelegram() = _SuccessVerifyRegisterTelegram;
  const factory AuthState.successTelegramState({required SmsResponse model }) = _SuccessTelegramState;
  const factory AuthState.successResendOtpTelegram({required SmsResponse model }) = _SuccessResendOtpTelegram;
}
