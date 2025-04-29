import 'package:flutter/material.dart';

class UtilsDashboard {
  static final ValueNotifier<int?> _isSelected = ValueNotifier(0);

  static set setIsSelected(int? value) {
    _isSelected.value = value;
  }

  static ValueNotifier<int?> get isSelected => _isSelected;
}
