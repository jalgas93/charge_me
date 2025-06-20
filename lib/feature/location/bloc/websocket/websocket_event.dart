part of 'websocket_bloc.dart';

@freezed
class WebsocketEvent with _$WebsocketEvent {

  const factory WebsocketEvent.connect(
      {required String stationId}) = _Connect;

  const factory WebsocketEvent.disconnectedWebSocket() = _DisconnectWebSocket;

  const factory WebsocketEvent.sendWebSocketMessage({required String message}) =
      _SendWebSocketMessage;

  const factory WebsocketEvent.booking() = _Booking;

  const factory WebsocketEvent.charging() = _Charging;
  const factory WebsocketEvent.finish() = _Finish;
}
