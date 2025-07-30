import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/payment/model/payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/logging/log.dart';
import '../payment_repository.dart';

part 'payment_event.dart';

part 'payment_state.dart';

part 'payment_bloc.freezed.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  PaymentBloc({required PaymentRepository repository})
      : _repository = repository,
        super(const PaymentState.initial()) {
    on<PaymentEvent>((event, emit) => _payment(event, emit));
  }

  Future<void> _payment(
    PaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    await event.map(getBalance: (event) async {
      emit(const PaymentState.loading());
      try {
        final dynamic response = await _repository.getBalance();
        Log.i(response);
        emit(PaymentState.successBalance(
            paymentModel: PaymentModel.fromJson(response)));
      } catch (e) {
        emit(PaymentState.error(error: e));
      }
    }, check: (event) async {
      emit(const PaymentState.loading());
      try {
        final dynamic response = await _repository.check(
          command: event.command,
          txnId: event.txnId,
          account: event.account,
          sum: event.sum,
        );
        Log.i(response);
        emit(PaymentState.successCheck(
            paymentResponse: PaymentResponse.fromJson(response)));
      } catch (e) {
        emit(PaymentState.error(error: e));
      }
    }, pay: (event) async {
      emit(const PaymentState.loading());
      try {
        final dynamic response = await _repository.pay(
          command: event.command,
          txnId: event.txnId,
          account: event.account,
          sum: event.sum,
          txnDate: event.txnDate,
        );
        Log.i(response);
        emit(PaymentState.successPay(
            paymentResponse: PaymentResponse.fromJson(response)));
      } catch (e) {
        emit(PaymentState.error(error: e));
      }
    });
  }
}
