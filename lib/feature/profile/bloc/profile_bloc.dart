import 'package:bloc/bloc.dart';
import 'package:charge_me/core/helpers/app_user.dart';
import 'package:charge_me/feature/profile/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) => _getUser(event, emit));
  }

  Future<void> _getUser(ProfileEvent event, Emitter<ProfileState> emit) async {
    await event.map(
        getUser: (event) async {
          emit(const ProfileState.loading());
          try {
            final response = await _repository.getUser(
                userId: event.userId);
            emit(ProfileState.successGetUser(user: User.fromJson(response)));
          } catch (e) {
            emit(ProfileState.error(error: e.toString()));
          }
        },
        updateUser: (event) async {},
        deleteUser: (event) async {},
        avatarUser: (event) async {});
  }
}
