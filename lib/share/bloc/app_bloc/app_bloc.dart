import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/account/model/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/helpers/app_user.dart';
import '../../../core/utils/flutter_secure_storage.dart';
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
        final dynamic response = await _repository.userSettings(userId: AppUser.userModel?.userId ??  1);
        AppUser.setUserModel = UserModel.fromJson(response);
        await SecureStorageService.getInstance
            .setValue("access_token", response['accessToken']);
        await SecureStorageService.getInstance
            .setValue("refresh_token", response['refreshToken']);

      emit(const AppState.success());
    } catch (e) {
      emit(AppState.error(error: e));
    }
  }
}
