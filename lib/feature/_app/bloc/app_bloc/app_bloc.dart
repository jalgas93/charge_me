import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/account/model/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/helpers/app_user.dart';
import '../../app_repository.dart';

part 'app_event.dart';

part 'app_state.dart';

part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _repository;

  AppBloc({required AppRepository repository})
      : _repository = repository,
        super(const AppState.initial()) {
    on<AppEvent>((event, emit) => _initial(event, emit));
  }

  Future<void> _initial(
    AppEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.loading());
    try {
      if (AppUser.userModel?.userId != null) {
        final response = await _repository.userSettings(
            userId: AppUser.userModel!.userId ?? 0);
        AppUser.setUserModel = UserModel.fromJson(response);
        AppUser.setUserSession(
          accessToken: response['accessToken'],
          refreshToken: response['refreshToken'],
        );
        emit(const AppState.success());
      } else {
        emit(AppState.error(error: 'userId: null'.toString()));
      }
    } catch (e) {
      emit(AppState.error(error: e));
    }
  }
}
