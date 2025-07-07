part of 'websocket_bloc.dart';

@freezed
class WebsocketEvent with _$WebsocketEvent {

  const factory WebsocketEvent.connect(
      {required String stationId}) = _Connect;

  const factory WebsocketEvent.disconnectedWebSocket() = _DisconnectWebSocket;

  const factory WebsocketEvent.connector({required String message}) =
      _Connector;

  const factory WebsocketEvent.booking({required String message}) = _Booking;
  const factory WebsocketEvent.queue({required String message}) = _Queue;

  const factory WebsocketEvent.bookingCancel({required String message}) = _BookingCancel;

  const factory WebsocketEvent.charging({required String message}) = _Charging;

  const factory WebsocketEvent.finish({required String message}) = _Finish;
}
