import 'package:flutter/material.dart';

class UtilsDashboard {
  static final ValueNotifier<int?> _isSelected = ValueNotifier(0);

  static set setIsSelected(int? value) {
    _isSelected.value = value;
  }

  static ValueNotifier<int?> get isSelected => _isSelected;

  static final ValueNotifier<bool> _change = ValueNotifier(false);

  static set setChange(bool value) {
    _change.value = value;
  }

  static ValueNotifier<bool> get change => _change;
}
