import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:charge_me/feature/location/utils/utils_location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/logging/log.dart';
import '../../../../core/network/http/websocket_new.dart';
import '../../location_repository.dart';
import '../../model/stations.dart';

part 'websocket_event.dart';

part 'websocket_state.dart';

part 'websocket_bloc.freezed.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final LocationRepository _locationRepository;
  final WebSocketService _webSocketService;

  WebsocketBloc(
      {required LocationRepository locationRepository,
      required WebSocketService websocketService})
      : _locationRepository = locationRepository,
        _webSocketService = websocketService,
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
        _webSocketService.connect(stationId: event.stationId).then((value) {
          add(WebsocketEvent.connector(
            message: jsonEncode({
              "action": "Connector",
              "messageId": "connector",
            }),
          ));
        });
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, connector: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.connector(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              UtilsLocation.setMessage = errorMessage;
            } else {
              emit(WebsocketState.connectorSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, booking: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.booking(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              UtilsLocation.setMessage = errorMessage;
            } else {
              emit(WebsocketState.bookingSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, queue: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.queue(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              print('errorObject ${errorMessage}');
              UtilsLocation.setMessage = errorMessage;
              //emit(WebsocketState.connectorSuccess(message: data));
            } else {
              emit(WebsocketState.queueSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, charging: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.charging(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              UtilsLocation.setMessage = errorMessage;
            } else {
              emit(WebsocketState.chargingSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, finish: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.finish(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              UtilsLocation.setMessage = errorMessage;
            } else {
              emit(WebsocketState.finishSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    }, disconnectedWebSocket: (event) {
      emit(const WebsocketState.loadingWebSocket());
      try {
        _webSocketService.disconnect();
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
      emit(const WebsocketState.disconnectWebSocket());
    }, bookingCancel: (event) async {
      emit(const WebsocketState.loadingWebSocket());
      try {
        await emit.onEach(
          _locationRepository.bookingCancel(message: event.message),
          onData: (data) {
            if (data['status'] == 'Error') {
              final errorMessage = data['message'] ?? 'Unknown error';
              UtilsLocation.setMessage = errorMessage;
            } else {
              emit(WebsocketState.connectorSuccess(message: data));
            }
          },
          onError: (error, stackTrace) {
            emit(WebsocketState.errorWebSocket(error: error.toString()));
          },
        );
      } catch (e) {
        emit(WebsocketState.errorWebSocket(error: e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    _webSocketService.disconnect();
    return super.close();
  }

/*  @override
  void onTransition(Transition<WebsocketEvent, WebsocketState> transition) {
    super.onTransition(transition);
    Log.i("WebsocketBloc: $transition");
  }*/
}
