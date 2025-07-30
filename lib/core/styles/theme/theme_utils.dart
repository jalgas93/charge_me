import 'package:flutter/material.dart';

import '../app_colors_dark.dart';
import '../app_colors_light.dart';

class ThemeUtils {
  static Color getIconColor(BuildContext context, bool isSelected) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isSelected
        ? isDark
        ? AppColorsDark.green2
        : AppColorsLight.primaryColor
        : isDark
        ? AppColorsDark.white2
        : AppColorsLight.unselectedColor;
  }
}