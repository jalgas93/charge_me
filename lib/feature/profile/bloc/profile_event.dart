part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.getUser({required int userId}) = _GetUser;
  const factory ProfileEvent.updateUser({required int userId}) = _UpdateUser;
  const factory ProfileEvent.deleteUser({required int userId}) = _DeleteUser;
  const factory ProfileEvent.avatarUser({required int userId}) = _AvatarUser;

}
