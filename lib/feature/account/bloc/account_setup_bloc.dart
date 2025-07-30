import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/account/account_repository.dart';
import 'package:charge_me/feature/account/model/add_car/add_car.dart';
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
    await event.map(started: (event) async {
      emit(const AccountSetupState.loading());
      try {
        emit(const AccountSetupState.success());
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    }, addLocation: (event) async {
      emit(const AccountSetupState.loading());
      try {
        final dynamic response = await _repository.addLocation(
            latitude: event.latitude,
          longitude: event.latitude,
          road: event.road,
          userId: event.userId,
        );
        emit(const AccountSetupState.successAddLocation());
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    }, addCar: (event) async {
      emit(const AccountSetupState.loading());
      try {
        await _repository.addCar(
          manufacture: event.manufacture,
          model: event.model,
          connector: event.connector,
          makeYear: event.makeYear,
          registrationNumber: event.registrationNumber,
          batteryCapacity: event.batteryCapacity,
          plug: event.plug,
          userId: event.userId,
        );
        emit(const AccountSetupState.successAddCar());
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    }, geocode: (value) {},
        updateUser: (event) async {
      emit(const AccountSetupState.loading());
      try {
        final response = await _repository.userUpdate(
          firstname: event.firstname,
          avatar: event.avatar,
          role: event.role,
          userId: event.userId,
        );
        emit(const AccountSetupState.success());
      } catch (e) {
        emit(AccountSetupState.error(error: e));
      }
    });
  }
}
