import 'package:flutter/material.dart';

enum TileEnum { tile, list }

class Utils {
  static final ValueNotifier<TileEnum> _changeTile =
      ValueNotifier(TileEnum.tile);

  static set setTile(TileEnum value) {
    _changeTile.value = value;
  }

  static ValueNotifier<TileEnum> get changeTile => _changeTile;
}
