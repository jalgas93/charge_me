part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;


  const factory ProfileState.loading() = _Loading;

  const factory ProfileState.error({required dynamic error}) = _Error;

  const factory ProfileState.successGetUser({required User user}) =
  _SuccessGetUser;
}
