import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  static FlutterSecureStorage? storage;

  /// Private constructor, not async
  SecureStorageService._internal() {
    storage = const FlutterSecureStorage();
  }


  /// static singleton instance getter, not async
  static SecureStorageService get getInstance => _instance;

  /// don't need "this" keyword & could use FSS methods directly, but leaving as is
  Future<bool> setValue(String key, String value) async {
    await storage?.write(key: key, value: value);
    return true;
  }
  Future<dynamic> getValue(String key) async {
    return await storage?.read(key: key);
  }

  Future<bool> clearValue(String key) async {
    await storage?.delete(key: key);
    return true;
  }
}
