part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.getBalance() = _GetBalance;
  const factory PaymentEvent.check({
    required String command,
    required String txnId,
    required int account,
    required num sum,
  }) = _Check;
  const factory PaymentEvent.pay({
    required String command,
    required String txnId,
    required int txnDate,
    required int account,
    required num sum,
  }) = _Pay;
}
