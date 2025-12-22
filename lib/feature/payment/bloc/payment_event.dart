part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.getAccount() = _GetAccount;
  const factory PaymentEvent.createAccount() = _CreateAccount;
  const factory PaymentEvent.check({
    required String command,
    required String txnId,
    required int account,
    required num sum,
  }) = _Check;
  const factory PaymentEvent.pay({
    required String command,
    required String txnId,
    required String txnDate,
    required int account,
    required num sum,
  }) = _Pay;
}
