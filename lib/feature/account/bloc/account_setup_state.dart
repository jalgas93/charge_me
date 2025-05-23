part of 'account_setup_bloc.dart';

@freezed
class AccountSetupState with _$AccountSetupState {
  const factory AccountSetupState.initial() = _Initial;
  const factory AccountSetupState.loading() = _Loading;
  const  factory AccountSetupState.error({required dynamic error}) = _Error;
  const factory AccountSetupState.success() = _Success;
}
