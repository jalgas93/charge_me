import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
}
