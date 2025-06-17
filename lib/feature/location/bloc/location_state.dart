part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const  factory LocationState.error({required dynamic error}) = _Error;
  const factory LocationState.successLocation({required List<Station> list }) = _SuccessAllLocation;
}
