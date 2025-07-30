/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/dialog.dart';



class PermissionUtil {

  static void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }
  /// Разрешения для Android
  static List<Permission> androidPermissions = <Permission>[
    // Добавьте необходимые разрешения здесь
    Permission.storage
  ];

  /// ios权限
  static List<Permission> iosPermissions = <Permission>[
    // Добавьте необходимые разрешения здесь
    Permission.storage
  ];

  static Future<Map<Permission, PermissionStatus>> requestAll() async {
    if (Platform.isIOS) {
      return await iosPermissions.request();
    }
    return await androidPermissions.request();
  }

  static Future<Map<Permission, PermissionStatus>> request(
      Permission permission) async {
    final List<Permission> permissions = <Permission>[permission];
    return await permissions.request();
  }

  static bool isDenied(Map<Permission, PermissionStatus> result) {
    var isDenied = false;
    result.forEach((key, value) {
      if (value == PermissionStatus.denied) {
        isDenied = true;
        return;
      }
    });
    return isDenied;
  }
  static void showDeniedDialog(BuildContext context) {
    HDialog.show(
        context: context,
        title: 'Ненормальное применение разрешений',
        content: 'Пожалуйста, включите все необходимые разрешения в разделе [Информация о приложении]-[Управление правами], чтобы нормально использовать единую функцию Huibong',
        options: <DialogAction>[
          DialogAction(text: 'Зайдите в настройки', onPressed: () => openAppSettings())
        ]);
  }

  /// Проверьте права доступа
  static Future<bool> checkGranted(Permission permission) async {
    PermissionStatus storageStatus = await permission.status;
    if (storageStatus == PermissionStatus.granted) {
      //Уполномоченный
      return true;
    } else {
      //Отказать в авторизации
      return false;
    }
  }
}*/
