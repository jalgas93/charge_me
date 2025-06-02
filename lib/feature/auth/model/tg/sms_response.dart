import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_response.freezed.dart';
part 'sms_response.g.dart';

@freezed
class SmsResponse with _$SmsResponse {
  const factory SmsResponse({
    @JsonKey(name: 'ok') bool? ok,
    @JsonKey(name: 'result') SmsResult? resultSms,
    @JsonKey(name: 'valid') bool? valid,
  }) = _SmsResponse;

  factory SmsResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsResponseFromJson(json);
}
@freezed
class SmsResult with _$SmsResult {
  const factory SmsResult({
    @JsonKey(name: 'request_id') String? requestId,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'request_cost') double? requestCost,
    @JsonKey(name: 'remaining_balance') double? remainingBalance,
    @JsonKey(name: 'delivery_status') DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'verification_status') VerificationStatus? verificationStatus,
  }) = _SmsResult;

  factory SmsResult.fromJson(Map<String, dynamic> json) =>
      _$SmsResultFromJson(json);
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
