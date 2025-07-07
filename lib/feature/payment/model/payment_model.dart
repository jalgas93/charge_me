import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';

part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  factory PaymentModel({
    @JsonKey(name: 'accountId') String? accountId,
    @JsonKey(name: 'balance') num? balance,
    @JsonKey(name: 'lastUpdated') DateTime? lastUpdated,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
@freezed
class PaymentResponse with _$PaymentResponse {
  factory PaymentResponse({
    @JsonKey(name: 'txn_id') String? txnId,
    @JsonKey(name: 'prv_txn_id') String? prvTxnId,
    @JsonKey(name: 'result') String? result,
    @JsonKey(name: 'sum') num? sum,
    @JsonKey(name: 'comment') String? comment,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);
}
