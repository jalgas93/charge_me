import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_status.freezed.dart';
part 'telegram_status.g.dart';

/*part 'result.freezed.dart';
part 'result.g.dart';

part 'delivery_status.freezed.dart';
part 'delivery_status.g.dart';

part 'verification_status.freezed.dart';
part 'verification_status.g.dart';*/

@freezed
class TelegramStatus with _$TelegramStatus {
  factory TelegramStatus({
    @JsonKey(name: 'ok') bool? phone,
    @JsonKey(name: 'result') String? firstname,
    @JsonKey(name: 'valid') bool? valid,
  }) = _TelegramStatus;

  factory TelegramStatus.fromJson(Map<String, dynamic> json) =>
      _$TelegramStatusFromJson(json);
}
@freezed
class Result with _$Result{
  factory Result({
    @JsonKey(name: 'request_id') String? requestId,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'request_cost') double? requestCost,
    @JsonKey(name: 'remaining_balance') double? remainingBalance,
    @JsonKey(name: 'delivery_status') DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'verification_status') double? verificationStatus,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);
}

@freezed
class DeliveryStatus with _$DeliveryStatus{
  factory DeliveryStatus({
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'updated_at') int? updatedAt,
  }) = _DeliveryStatus;

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) =>
      _$DeliveryStatusFromJson(json);
}

@freezed
class VerificationStatus with _$VerificationStatus{
  factory VerificationStatus({
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'updated_at') int? updatedAt,
    @JsonKey(name: 'code_entered') int? codeEntered,
  }) = _VerificationStatus;

  factory VerificationStatus.fromJson(Map<String, dynamic> json) =>
      _$VerificationStatusFromJson(json);
}
