import '../../feature/account/model/user_model/user_model.dart';
import '../../share/utils/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class AppUser {

  final navigatorKey = GlobalKey<NavigatorState>();
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

  static ValueNotifier<UserModel?> get userModel => _userModel;
}
