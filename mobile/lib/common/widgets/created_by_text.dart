import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class CreatedByText extends StatelessWidget {
  const CreatedByText({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Text(
        "[created by TWG]",
        style: TextStyle(
          fontSize: 12.sp,
          color: color ?? AUColors.mainGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
