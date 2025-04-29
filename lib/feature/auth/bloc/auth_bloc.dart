import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/auth/model/sign_in/sign_in_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth_repository.dart';
import '../model/register/register_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) => _auth(event, emit));
  }

  Future<void> _auth(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await event.map(
        started: (event) async {},
        registerWithUsername: (event) async {
          emit(const AuthState.loading());
          try {
            final response = await _repository.registerByUsername(
              username: event.username,
              phone: event.phone,
              password: event.password,
              firstname: event.firstname,
              avatar: event.avatar,
            );
            emit(AuthState.successRegisterWithUsername(registerModel: RegisterModel.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        },
        loginWithUsername: (event) async {
          emit(const AuthState.loading());
          try {
            final response = await _repository.loginWithUsername(
                username: event.username,
                password: event.password
            );
            emit(AuthState.successLoginWithUsername(signInModel: SignInModel.fromJson(response)));
          } catch (e) {
            emit(AuthState.error(error: e));
          }
        });
  }
}
