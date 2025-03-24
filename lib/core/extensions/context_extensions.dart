import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);

  TextTheme get textTheme => theme.textTheme;

  Uint8List? getImageBase64(imageBase64) {
    final image = base64.decode(imageBase64);
    return image;
  }

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSnackBarUsingText(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
