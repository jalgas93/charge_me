part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;

  const factory PaymentState.loading() = _Loading;

  const factory PaymentState.error({required dynamic error}) = _Error;

  const factory PaymentState.successCreateAccount({required PaymentModel paymentModel}) =
  _SuccessCreateAccount;
  const factory PaymentState.successGetAccount({required PaymentModel paymentModel}) =
  _SuccessGetAccount;
  const factory PaymentState.successCheck({required ResponseCheck responseCheck}) =_SuccessCheck;
  const factory PaymentState.successPay({required PaymentResponse paymentResponse}) =_SuccessPay;
}
