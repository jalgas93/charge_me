part of 'account_setup_bloc.dart';

@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  const factory AccountSetupEvent.started() = _Started;
  const factory AccountSetupEvent.geocode() = _Geocode;
}
