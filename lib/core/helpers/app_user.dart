import 'dart:convert';
import 'dart:ffi';

import '../../feature/_app/utils/flutter_secure_storage.dart';
import '../../feature/account/model/user_model/user_model.dart';
import 'package:flutter/material.dart';

import '../application.dart';
import '../utils/constant/shared_preferences_keys.dart';

class AppUser {
  static String? token;

/*   static final accessToken = SecureStorageService.getInstance.getValue("access_token");
   static final refreshToken = SecureStorageService.getInstance.getValue("refresh_token");


   Future<bool> accessToken()async{
     var result = await SecureStorageService.getInstance.getValue("access_token");
     if(result !=null){
       return true;
     }else{
       return false;
     }
   }*/
  static final ValueNotifier<UserModel?> _userModel = ValueNotifier(null);

  static set setUserModel(UserModel? value) {
    _userModel.value = value;
  }

  static UserModel? get userModel => _userModel.value;

  static Future<void> setUserSession({
    required String accessToken,
    required String refreshToken,
  }) async {
    token = accessToken;
    await SecureStorageService.getInstance
        .setValue("access_token", accessToken);
    await SecureStorageService.getInstance
        .setValue("refresh_token", refreshToken);
    await Application.sharedPreferences?.setString(
        SharedPreferencesKeys.userSessionInfo, jsonEncode(userModel?.toJson()));
  }

  static Future<void> loadDeviceAndUserData() async {

    bool? issetSessionInfo = Application.sharedPreferences
        ?.containsKey(SharedPreferencesKeys.userSessionInfo);
    if (issetSessionInfo!) {
      setUserModel = UserModel.fromJson(jsonDecode(Application.sharedPreferences!.getString(SharedPreferencesKeys.userSessionInfo)!));
    }
    token = await SecureStorageService.getInstance.getValue("access_token");
  }

  static void removeSession() async {
    await Application.sharedPreferences
        ?.remove(SharedPreferencesKeys.userSessionInfo);
    await SecureStorageService.getInstance
        .clearValue("access_token");
    await SecureStorageService.getInstance
        .clearValue("refresh_token");
    token =null;
    setUserModel = null;
  }
}
