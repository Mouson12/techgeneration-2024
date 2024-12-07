import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/l10n/extensions.dart';
import 'package:office_app/features/home_page_bottom_stats/data/time_type.dart';

class HomePageBottomStats extends StatelessWidget {
  const HomePageBottomStats({
    super.key,
    required this.goodMinutes,
    required this.badMinutes,
    required this.breakMinutes,
  });

  final double goodMinutes;
  final double badMinutes;
  final double breakMinutes;

  String minutesToHours(double totalMinutes) {
    // Convert total minutes to hours and minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes.toInt() % 60;

    // Format hours and minutes as strings with leading zeros if necessary
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr h';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildItem(context, goodMinutes, TimeType.badTime),
        buildItem(context, badMinutes, TimeType.goodTime),
        buildItem(context, breakMinutes, TimeType.breakTime),
      ],
    );
  }

  Widget buildItem(BuildContext context, double minutes, TimeType timeType) {
    double totalMinutes = goodMinutes + badMinutes + breakMinutes;
    late int percent;
    if (totalMinutes == 0) {
      percent = 0;
    } else {
      percent = (minutes / totalMinutes * 100).round();
    }

    // Color and text based on the custom type
    late Color color = AUColors.mainGreen;
    late String text = context.text.homePageBreakTime;

    if (timeType == TimeType.goodTime) {
      color = AUColors.greenStatus;
      text = context.text.homePageGoodPosture;
    }
    if (timeType == TimeType.badTime) {
      color = AUColors.pinkStatus;
      text = context.text.homePageBadPosture;
    }

    return SizedBox(
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$percent%",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: AUColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
          Text(
            minutesToHours(minutes),
            style: TextStyle(
              color: AUColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          )
        ],
      ),
    );
  }
}
