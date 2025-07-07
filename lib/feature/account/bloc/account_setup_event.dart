part of 'account_setup_bloc.dart';

@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  const factory AccountSetupEvent.started() = _Started;
  const factory AccountSetupEvent.geocode({
    required double latitude,
    required double longitude,
  }) = _Geocode;

  const factory AccountSetupEvent.addLocation(
      {required double latitude,
        required double longitude,
        String? country,
        String? county,
        String? city,
        String? road,
        String? town,
        required int userId,
      }) = _AddLocation;

  const factory AccountSetupEvent.addCar({
    required String manufacture,
    required String model,
    required String connector,
    required String makeYear,
    required String registrationNumber,
    required String batteryCapacity,
    required String plug,
    required int userId,
  }) = _AddCar;
}
