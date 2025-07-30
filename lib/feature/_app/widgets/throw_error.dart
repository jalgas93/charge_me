import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ThrowError {
  static void showMessage({
    required String errMessage,
    required BuildContext context,
    int duration = 1,
  }) {
     showError(context: context, errMessage: errMessage,duration: duration);
  }
  static void showNotify({
    required BuildContext context,
    required String errMessage,
    dynamic exception,
    int duration = 3000,
}){
    _display(
      message: errMessage,
      context: context,
      colors: [Colors.red[400]!, Colors.red[500]!],
    );
  }

  static  showError(
      {required BuildContext context, required String errMessage,required int duration}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:Theme.of(context).primaryColor,
      duration: Duration(seconds: duration),
      content: Text(errMessage,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white)),
      action: SnackBarAction(label: '', onPressed: () {},
      ),
    ));
  }

  static Future<void> _display({
    required String message,
    required BuildContext context,
    int duration = 3000,
    required List<Color> colors,
    Widget? icon,
    bool? shouldIconPulse,
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    return Flushbar(
      duration: Duration(milliseconds: duration),
      message: message,
      margin: const EdgeInsets.all(10.0),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      icon: icon,
      shouldIconPulse: shouldIconPulse ?? false,
      flushbarPosition: position,
      backgroundGradient: LinearGradient(
        colors: colors,
        end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
      ),
    ).show(context);
  }
}
