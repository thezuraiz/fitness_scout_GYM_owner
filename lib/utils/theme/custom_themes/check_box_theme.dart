import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ZCheckBoxTheme {
  ZCheckBoxTheme._();

  // --- LIGHT CHECKBOX THEME
  static CheckboxThemeData ligthCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ZColor.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  // --- DARK CHECKBOX THEME
  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ZColor.primary;
        } else {
          return Colors.transparent;
        }
      }));
}
