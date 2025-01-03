import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/progress_theme.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/switch_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/check_box_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button.dart';
import 'custom_themes/textTheme.dart';
import 'custom_themes/textformfield_theme.dart';

class AppTheme {
  AppTheme._(); // To make its constructor private

  // --- Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ZTextTheme.lightTextTheme,
    chipTheme: ZChipTheme.lightChipThemeData,
    appBarTheme: ZAppBarTheme.lightAppBarTheme,
    checkboxTheme: ZCheckBoxTheme.ligthCheckboxTheme,
    bottomSheetTheme: ZBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: ZElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ZOutlinedButton.lightOutlinedButtonTheme,
    inputDecorationTheme: ZTextFormFieldTheme.lightTextFormField,
    switchTheme: ZSwitchTheme.lightSwitchThemeData,
    progressIndicatorTheme: ZProgressTheme.lightProgressIndicatorTheme,
  );

  // --- Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: ZColor.black,
    textTheme: ZTextTheme.darkTextTheme,
    chipTheme: ZChipTheme.darkChipThemeData,
    appBarTheme: ZAppBarTheme.darkAppBarTheme,
    checkboxTheme: ZCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: ZBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: ZElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ZOutlinedButton.darkOutlinedButtonTheme,
    inputDecorationTheme: ZTextFormFieldTheme.darkTextFormField,
    switchTheme: ZSwitchTheme.darkSwitchThemeData,
    progressIndicatorTheme: ZProgressTheme.lightProgressIndicatorTheme,
  );
}
