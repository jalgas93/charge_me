import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/account/account_repository.dart';
import 'package:charge_me/feature/auth/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_setup_event.dart';

part 'account_setup_state.dart';

part 'account_setup_bloc.freezed.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  final AccountSetupRepository _repository;

  AccountSetupBloc({required AccountSetupRepository repository})
      : _repository = repository,
        super(const AccountSetupState.initial()) {
    on<AccountSetupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
