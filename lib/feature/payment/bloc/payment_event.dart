part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.getBalance() = _GetBalance;
  const factory PaymentEvent.topUpBalance({
    required String command,
    required String txnId,
    required int account,
    required num sum,
    required int txnDate,
  }) = _TopUpBalance;
}
