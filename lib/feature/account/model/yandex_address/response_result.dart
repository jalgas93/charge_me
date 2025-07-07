import 'package:yandex_mapkit/yandex_mapkit.dart';

class ResponseResult {
  String? address;
  Point? point;

  ResponseResult({required this.address, required this.point});

  String? get a => address;
}
