
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'firstname') String? firstname,
    @JsonKey(name: 'birth_date') DateTime? birthDate,
    @JsonKey(name: 'role') String? role ,
    @JsonKey(name: 'createAt') String? createAt,
    @JsonKey(name: 'device') String? device,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'car') String? car,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}

@freezed
class Device with _$Device {
  factory Device({
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'fcmToken') String? fcmToken,
    @JsonKey(name: 'deviceName') String? deviceName,
    @JsonKey(name: 'deviceUuid') String? deviceUuid,
    @JsonKey(name: 'appBuildVersion') String? appBuildVersion
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) =>
      _$DeviceFromJson(json);
}

@freezed
class Location with _$Location {
  factory Location({
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'county') String? county,
    @JsonKey(name: 'city') String? city ,
    @JsonKey(name: 'road') String? road,
    @JsonKey(name: 'town') String? town
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Car with _$Car {
  factory Car({
    @JsonKey(name: 'manufacture') String? manufacture,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'connector') String? connector,
    @JsonKey(name: 'makeYear') DateTime? makeYear,
    @JsonKey(name: 'registrationNumber') String? registrationNumber ,
    @JsonKey(name: 'batteryCapacity') String? batteryCapacity,
    @JsonKey(name: 'plug') String? plug
  }) = _Car;

  factory Car.fromJson(Map<String, dynamic> json) =>
      _$CarFromJson(json);
}