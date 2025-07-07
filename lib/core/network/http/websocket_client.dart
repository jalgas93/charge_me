import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../share/utils/constant/config_app.dart';
import '../../../share/utils/flutter_secure_storage.dart';
import '../../logging/log.dart';

class WebSocketManager {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _isDisposed = false;
  int _reconnectDelay = 1;
  final _controller = StreamController<dynamic>.broadcast();

  static final WebSocketManager _instance = WebSocketManager._internal();

  factory WebSocketManager() => _instance;

  WebSocketManager._internal();

  Stream get stream => _controller.stream;

  Future<void> connect({required String stationId}) async {
    if (_channel != null) return;
    var accessToken =
        await SecureStorageService.getInstance.getValue("access_token");

    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse('${ConfigApp.websocket}ws/station/$stationId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
      );

      _subscription = _channel!.stream.listen(
        (event) {
          _eventListener(event);
          if (_channel != null && event != null) {
            Map<String, dynamic> map = jsonDecode(event);
            _controller.add(map); // Передаем данные в StreamBuilder
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          _controller.addError(error); // Передаем ошибку
          _reconnect(stationId: stationId);
        },
        onDone: () {
          _controller.sink.close(); // Закрываем StreamBuilder
          _reconnect(stationId: stationId);
        },
      );

      print('WebSocket connected');
      _reconnectDelay = 1; // Reset delay after successful connection
    } catch (e) {
      print('Connection error: $e');
      _reconnect(stationId: stationId);
    }
  }

  Future<void> transmit(dynamic data) async {
    if (_channel != null) {
      _channel!.sink.add(data);
    }
  }

  void _eventListener(dynamic event) {
    Log.i('Received event',event);
  }

  void _reconnect({required String stationId}) {
    if (_isDisposed) return;

    // Cancel existing subscription if exists
    _subscription?.cancel();
    _subscription = null;

    // Close existing channel if exists
    _channel?.sink.close();
    _channel = null;

    // Exponential backoff with max 30 seconds delay
    final delay = Duration(seconds: _reconnectDelay);
    _reconnectDelay = (_reconnectDelay * 2).clamp(1, 30);

    print('Reconnecting in ${delay.inSeconds}s...');

    Timer(delay, () {
      if (!_isDisposed) connect(stationId: stationId);
    });
  }

  Future<void> disconnect() async {
    _isDisposed = true;
    await _subscription?.cancel();
    await _channel?.sink.close();
    _subscription = null;
    _channel = null;
  }
}
