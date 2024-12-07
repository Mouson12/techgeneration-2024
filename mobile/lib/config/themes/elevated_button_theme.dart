import 'package:flutter/material.dart';
import 'package:office_app/config/colors.dart';

class BBElevatedButtonTheme {
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AUColors.mainGreen,
      backgroundColor: AUColors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
    ),
  );
}
