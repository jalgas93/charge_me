import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'app_event.dart';

part 'app_state.dart';

part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.initial()) {
    on<AppEvent>((event, emit) => _initial(event, emit));
  }

  Future<void> _initial(
    AppEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(const AppState.loading());

      emit(const AppState.success());
    } catch (e) {
      emit(AppState.error(error: e));
    }
  }
}
