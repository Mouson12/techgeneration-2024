import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class BBInputDecorationTheme {
  static final inputDecorationTheme = InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AUColors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AUColors.white),
    ),
    hintStyle: TextStyle(color: AUColors.white, fontSize: 12.sp),
  );
}
