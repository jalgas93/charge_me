import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/logging/log.dart';
import '../../../../core/network/http/websocket_new.dart';
import '../../../../core/utils/flutter_secure_storage.dart';

part 'websocket_event.dart';

part 'websocket_state.dart';

part 'websocket_bloc.freezed.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final WebSocketService _webSocketService;

  WebsocketBloc({required WebSocketService webSocketService})
      : _webSocketService = webSocketService,
        super(const WebsocketState.initial()) {
    on<WebsocketEvent>((event, emit) => _onConnect(event, emit));
  }

  Future<void> _onConnect(
    WebsocketEvent event,
    Emitter<WebsocketState> emit,
  ) async {
    await event.map(connect: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        _webSocketService.connect(stationId: event.stationId);

        await emit.onEach(
          _webSocketService.stream,
          onData: (data) {
            emit(WebsocketState.receivedWebSocketMessage(message: data));
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    },sendWebSocketMessage: (event) async{
      emit(const WebsocketState.loadingWebSocket());
      try {
        _webSocketService.channel?.sink.add(event.message);
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    },
      disconnectedWebSocket: (event) {
      _webSocketService.disconnect();
      emit(const WebsocketState.disconnectWebSocket());
    }, booking: (event) {
        emit(const WebsocketState.loadingWebSocket());
        try {
         emit(const WebsocketState.bookingSuccess());
        } catch (e) {
          emit(WebsocketState.errorWebSocket(error: e.toString()));
        }
      }, charging: (event) {
        emit(const WebsocketState.loadingWebSocket());
        try {
          emit(const WebsocketState.chargingSuccess());
        } catch (e) {
          emit(WebsocketState.errorWebSocket(error: e.toString()));
        }
      },
      finish: (event){
        emit(const WebsocketState.loadingWebSocket());
        try {
          emit(const WebsocketState.finishSuccess());
        } catch (e) {
          emit(WebsocketState.errorWebSocket(error: e.toString()));
        }
      }
    );
  }

  @override
  Future<void> close() {
    _webSocketService.disconnect();
    return super.close();
  }
}
