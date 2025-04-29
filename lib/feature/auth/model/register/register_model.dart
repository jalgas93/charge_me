import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

@freezed
class RegisterModel with _$RegisterModel {
  factory RegisterModel({
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'firstname') String? firstname,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'avatar') String? avatar,
  }) = _RegisterModel;

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
}
