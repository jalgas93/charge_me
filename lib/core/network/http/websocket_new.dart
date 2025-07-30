import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../feature/_app/utils/flutter_secure_storage.dart';
import '../../utils/constant/config_app.dart';

class WebSocketService {
  WebSocketChannel? channel;
  StreamSubscription? _subscription;
  bool _isDisposed = false;
  int _reconnectDelay = 1;
  final _controller = StreamController<dynamic>.broadcast();

  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  Stream get stream => _controller.stream ?? const Stream.empty();

  Future<WebSocketChannel> connect({required String stationId}) async {
    var accessToken =
        await SecureStorageService.getInstance.getValue("access_token");
    channel = IOWebSocketChannel.connect(
      Uri.parse('${ConfigApp.websocket}ws/station/$stationId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    _subscription = channel!.stream.listen(
      (event) {
        print('event $event');
        if (channel != null && event != null) {
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

    return channel!;
  }

  void _reconnect({required String stationId}) {
    if (_isDisposed) return;

    // Cancel existing subscription if exists
    _subscription?.cancel();
    _subscription = null;

    // Close existing channel if exists
    channel?.sink.close();
    channel = null;

    // Exponential backoff with max 30 seconds delay
    final delay = Duration(seconds: _reconnectDelay);
    _reconnectDelay = (_reconnectDelay * 2).clamp(1, 30);

    print('Reconnecting in ${delay.inSeconds}s...');

    Timer(delay, () {
      if (!_isDisposed) connect(stationId: stationId);
    });
  }

  void disconnect() async {
    _isDisposed = true;
    await _subscription?.cancel();
    await channel?.sink.close();
    _subscription = null;
  }
}
