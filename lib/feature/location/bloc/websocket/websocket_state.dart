part of 'websocket_bloc.dart';

@freezed
class WebsocketState with _$WebsocketState {
  const factory WebsocketState.initial() = _Initial;

  const factory WebsocketState.initialWebSocket() = _WebSocketInitial;

  const factory WebsocketState.loadingWebSocket() = _WebSocketLoading;

  const factory WebsocketState.connectWebSocket() = _WebSocketConnected;

  const factory WebsocketState.disconnectWebSocket() = _WebSocketDisconnect;

  const factory WebsocketState.errorWebSocket({required dynamic error}) =
      _WebSocketError;

  const factory WebsocketState.receivedWebSocketMessage(
      {required dynamic message}) = _WebSocketMessageReceived;

  const factory WebsocketState.bookingSuccess() = _BookingSuccess;

  const factory WebsocketState.chargingSuccess() = _ChargingSuccess;

  const factory WebsocketState.finishSuccess() = _FinishSuccess;
}
