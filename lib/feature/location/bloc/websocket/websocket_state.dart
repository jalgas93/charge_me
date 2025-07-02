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

  const factory WebsocketState.connectorSuccess(
      {required dynamic message}) = _ConnectorSuccess;

  const factory WebsocketState.bookingSuccess({required dynamic message}) = _BookingSuccess;

  const factory WebsocketState.queueSuccess({required dynamic message}) = _QueueSuccess;

  const factory WebsocketState.bookingCancelSuccess({required dynamic message}) = _BookingCancelSuccess;

  const factory WebsocketState.chargingSuccess({required dynamic message}) = _ChargingSuccess;

  const factory WebsocketState.finishSuccess({required dynamic message}) = _FinishSuccess;
}
