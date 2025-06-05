import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_car.freezed.dart';
part 'add_car.g.dart';

@freezed
class AddCar with _$AddCar {
  const factory AddCar({
    @JsonKey(name: 'manufacture') String? manufacture,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'connector') String? connector,
    @JsonKey(name: 'makeYear') String? makeYear,
    @JsonKey(name: 'registrationNumber') String? registrationNumber,
    @JsonKey(name: 'batteryCapacity') String? batteryCapacity,
    @JsonKey(name: 'plug') String? plug
  }) = _AddCar;

  factory AddCar.fromJson(Map<String, dynamic> json) =>
      _$AddCarFromJson(json);
}