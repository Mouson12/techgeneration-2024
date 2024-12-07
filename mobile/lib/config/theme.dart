import 'package:flutter/material.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/themes/elevated_button_theme.dart';
import 'package:office_app/config/themes/input_decoration_theme.dart';
import 'package:office_app/config/themes/text_button_theme.dart';

class BBTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AUColors.white,
    textButtonTheme: BBTextButtonTheme.textButtonTheme,
    elevatedButtonTheme: BBElevatedButtonTheme.elevatedButtonTheme,
    inputDecorationTheme: BBInputDecorationTheme.inputDecorationTheme,
  );
}
