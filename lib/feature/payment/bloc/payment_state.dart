part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;

  const factory PaymentState.loading() = _Loading;

  const factory PaymentState.error({required dynamic error}) = _Error;

  const factory PaymentState.successBalance({required PaymentModel paymentModel}) =
  _SuccessBalance;
  const factory PaymentState.successTopUpBalance({required PaymentResponse paymentResponse}) =
  _SuccessTopUpBalance;
}
