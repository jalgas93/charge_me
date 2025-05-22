import 'package:flutter/material.dart';

enum SocialNetworkEnum {telegram,wechat,whatsapp}
class AuthUtils{
  static final ValueNotifier<int?> _isSocialNetwork = ValueNotifier(0);

  static set setIsSocialNetwork(int? value) {
    _isSocialNetwork.value = value;
  }

  static ValueNotifier<int?> get isSocialNetwork => _isSocialNetwork;
}