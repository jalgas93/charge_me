

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stations.freezed.dart';

part 'stations.g.dart';

@freezed
class Stations with _$Stations {
  factory Stations({
    @JsonKey(name: 'list') List<Station>? list,
  }) = _Stations;

  factory Stations.fromJson(Map<String, dynamic> json) =>
      _$StationsFromJson(json);
}

@freezed
class Station with _$Station {
  factory Station({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'externalId') String? externalId,
    @JsonKey(name: 'vendor') String? vendor,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'lastHeartBeat') DateTime? lastHeartBeat,
    @JsonKey(name: 'registeredAt') DateTime? registeredAt,
    @JsonKey(name: 'lastStatusNotification') DateTime? lastStatusNotification,
    @JsonKey(name: 'location') Location? location,
    @JsonKey(name: 'connectors') List<Connector>? connectors,
  }) = _Station;

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);
}

@freezed
class Location with _$Location {
  factory Location({
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'road') String? road,
    @JsonKey(name: 'address') String? address,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Connector with _$Connector {
  factory Connector({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'energy_consumed') num? energyConsumed,
    @JsonKey(name: 'cost_per_kwh') num? costPerKwh,
    @JsonKey(name: 'blocked_by') String? blockedBy,
    @JsonKey(name: 'max_power') num? maxPower,
  }) = _Connector;

  factory Connector.fromJson(Map<String, dynamic> json) =>
      _$ConnectorFromJson(json);
}

@freezed
class ConnectorList with _$ConnectorList {
  factory ConnectorList({
    @JsonKey(name: 'action') String? action,
    @JsonKey(name: 'messageId') String? messageId,
    @JsonKey(name: 'payload') List<Connector>? payload,

  }) = _ConnectorList;

  factory ConnectorList.fromJson(Map<String, dynamic> json) =>
      _$ConnectorListFromJson(json);
}
