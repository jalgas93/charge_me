import '../../core/base_repository.dart';

class LocationRepository extends BaseRepository {

  Future<dynamic> getStations() async {
    final response = await client.get('api/v1/station/findAll');
    return response.data;
  }

  Stream<dynamic> connector({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      yield* Stream.value(message);
    }
  }
  Stream<dynamic> booking({required String message}) async*{
   webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      yield* Stream.value(message);
    }
  }
  Stream<dynamic> bookingCancel({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      yield* Stream.value(message);
    }
  }

  Stream<dynamic> charging({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      yield* Stream.value(message);
    }
  }
  Stream<dynamic> finish({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      yield* Stream.value(message);
    }
  }
}
