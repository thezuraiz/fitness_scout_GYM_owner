import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ZChipTheme{
  ZChipTheme._();

  // --- LIGHT MODE
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: ZColor.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: ZColor.black),
    selectedColor: ZColor.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
    checkmarkColor: ZColor.white
  );

  // --- DARK MODE
  static ChipThemeData darkChopThemeData = const ChipThemeData(
    disabledColor: ZColor.darkerGrey,
    labelStyle: TextStyle(color: ZColor.white),
    selectedColor: ZColor.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
    checkmarkColor: ZColor.white
  );
}