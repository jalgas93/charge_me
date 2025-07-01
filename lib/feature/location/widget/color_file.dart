import "package:flutter/material.dart";

import "../../../core/styles/app_colors_dark.dart";


class ColorFile{
  Color statusColor({required String status}){
    switch(status){
      case 'AVAILABLE':
        return AppColorsDark.white;
      case 'PREPARING':
        return AppColorsDark.yellow1;
      case 'CHARGING':
        return AppColorsDark.yellow1;
      case 'FINISHING':
        return AppColorsDark.white;
      case 'FAULTY':
        return AppColorsDark.red1;
      case 'BOOKING':
        return AppColorsDark.white;
      case 'UNAVAILABLE':
        return AppColorsDark.red2;
      default:
        return Colors.white;
    }
  }
}
