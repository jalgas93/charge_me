import '../../core/base_repository.dart';

class LocationRepository extends BaseRepository {

  Future<dynamic> getStations() async {
    final response = await client.get('api/v1/station/findAll');
    return response.data;
  }

  Stream<dynamic> connector({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='connector'){
        yield message;
      }
    }
  }
  Stream<dynamic> booking({required String message}) async*{
   webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='StartBooking'){
        yield message;
      }
    }
  }
  Stream<dynamic> queue({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='queue'){
        yield message;
      }
    }
  }
  Stream<dynamic> check({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='check'){
        yield message;
      }
    }
  }
  Stream<dynamic> bookingCancel({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='cancelBooking'){
        yield message;
      }
    }
  }

  Stream<dynamic> charging({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='startTransaction'){
        yield message;
      }
    }
  }
  Stream<dynamic> finish({required String message}) async*{
    webSocketService.channel?.sink.add(message);
    await for (var message in webSocketService.stream) {
      if(message['action']=='Exception'){
        yield message;
      }else if(message['messageId'] =='stopTransaction'){
        yield message;
      }
    }
  }
}
