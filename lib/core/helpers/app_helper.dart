import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AppHelper {
  AppHelper._();

  static String? paymentLastPressedCardId;

  static NumberFormat currencyFormatter =
      NumberFormat('###,###,###,##0.00', 'app');
  static NumberFormat currencyFormatterNoDecimal =
      NumberFormat('###,###,###,##0', 'app');

/*  static DateFormat dateFormatter = DateFormat('d MMM HH:mm',
      Application.language == 'oz' ? 'uz' : Application.language);

  static DateFormat dateFormatterWithYear = DateFormat('d MMM y, HH:mm',
      Application.language == 'oz' ? 'uz' : Application.language);

  static DateFormat dateOnlyFormatter = DateFormat(
      'd MMM y', Application.language == 'oz' ? 'uz' : Application.language);

  static DateFormat dateFormatterWithFullYear = DateFormat(
      'yyyy-MM-dd', Application.language == 'oz' ? 'uz' : Application.language);

  static DateFormat dateFormatterWithTime = DateFormat(
      'dd EEEE kk:mm', Application.language);*/

  static bool isNumeric(String str) {
    if (str == null) return false;
    return double.tryParse(str) != null;
  }

/*
  static String formatDate(
    int unixTime, {
    bool withYear = false,
  }) {
    if (withYear) {
      return dateFormatterWithYear
          .format(DateTime.fromMillisecondsSinceEpoch(unixTime * 1000));
    }
    return dateFormatter
        .format(DateTime.fromMillisecondsSinceEpoch(unixTime * 1000));
  }

  static String formatDateOnly(int unixTime) {
    return dateOnlyFormatter
        .format(DateTime.fromMillisecondsSinceEpoch(unixTime * 1000));
  }
  static String formatDateWithTime(int unixTime) {
    return dateFormatterWithTime
        .format(DateTime.fromMillisecondsSinceEpoch(unixTime));
  }
*/

  static String formatCurrency(
    dynamic value, {
    withDecimal = true,
  }) {
    value ??= 0;
    if (withDecimal) {
      return currencyFormatter.format(value);
    }
    return currencyFormatterNoDecimal.format(value);
  }

/*  static String getImageUrl(String imageName) {
    return '${Config.apiUrl}get-image/$imageName';
  }*/

  static String getRandomUuid({int length = 24}) {
    final uuid = Uuid();
    return uuid.v1().replaceAll('-', '').substring(0, length);
  }

/*  static String get getMaskedPhone {
    String? userPhone = AppUser.userDeviceData?.phone;
    final startIndex = userPhone?.substring(0, userPhone.length - 7);
    final maskedPhone =
        '+$startIndex****${AppUser.userDeviceData?.phone?.substring(startIndex!.length + 4)}';
    return maskedPhone;
  }*/

  static bool routePredicateOneOf(
    Route route,
    List<String> routeNames,
  ) {
    if (route is PageRouteBuilder && route.settings != null) {
      return routeNames.contains(route.settings.name);
    }
    if (route is PageRoute && route.settings != null) {
      if (route.settings is RouteData) {
        return routeNames.contains((route.settings as RouteData).path);
      }
      return routeNames.contains(route.settings.name);
    }

    return false;
  }
}

extension NumCurrencyDisplay on num {
  String get asCurrency => AppHelper.formatCurrency(this);

  String get asCurrencyNoDecimal =>
      AppHelper.formatCurrency(this, withDecimal: false);

  num get fromCents => this / 100;

  int get toCents => (this * 100).toInt();
}

extension CustomFormatter on String {
  String get asPhone =>
      '+${substring(0, 3)} ${substring(3, 5)} ${substring(5, 8)} ${substring(8, 10)} ${substring(10, 12)}';

  num get asNumber =>
      isEmpty ? 0 : num.parse(replaceAll(RegExp('[^0-9.]'), ''));

  double get asDouble => asNumber.toDouble();

  int get asInteger => asNumber.toInt();
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorUtils on Color {
  Color? mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}

extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool Function(T element, int index) test) {
    final List<T> result = [];
    for (var i = 0; i < length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}
