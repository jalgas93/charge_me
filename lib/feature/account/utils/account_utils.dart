import 'package:flutter/material.dart';

enum SelectConnectors { gbt, cc2, all }

class AccountUtils {
  static final ValueNotifier<SelectConnectors> _isConnectorSelection = ValueNotifier(SelectConnectors.gbt);

  static set setIsConnectorSelection(SelectConnectors value) {
    _isConnectorSelection.value = value;
  }

  static ValueNotifier<SelectConnectors> get isConnectorSelection => _isConnectorSelection;
}
