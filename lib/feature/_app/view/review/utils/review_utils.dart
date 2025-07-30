import 'package:flutter/material.dart';

class ReviewUtils {
  static final ValueNotifier<double> _changeRating = ValueNotifier(1.0);

  static set setChangeRating(double value) {
    _changeRating.value = value;
  }

  static ValueNotifier<double> get changeRating => _changeRating;
}
