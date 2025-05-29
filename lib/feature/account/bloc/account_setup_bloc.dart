import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/account/account_repository.dart';
import 'package:charge_me/feature/auth/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/yandex_address/geo_response.dart';

part 'account_setup_event.dart';

part 'account_setup_state.dart';

part 'account_setup_bloc.freezed.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  final AccountSetupRepository _repository;

  AccountSetupBloc({required AccountSetupRepository repository})
      : _repository = repository,
        super(const AccountSetupState.initial()) {
    on<AccountSetupEvent>((event, emit) => _accountSetup(event, emit));
  }

  Future<void> _accountSetup(
    AccountSetupEvent event,
    Emitter<AccountSetupState> emit,
  ) async {
    await event.map(started: (event) {
      emit(const AccountSetupState.loading());
      try {
        emit(const AccountSetupState.success());
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    }, geocode: (event) async {
      emit(const AccountSetupState.loading());
      try {
        final dynamic response = await _repository.address(
            latitude: 41.305912, longitude: 69.331843, lang: 'uz');
        emit(AccountSetupState.successGeocode(
            geoResponse: GeoResponse.fromJson(response)));
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    });
  }
}
