import 'package:flutter/material.dart';
import 'package:flutter_podium/flutter_podium.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class RankingPodium extends StatelessWidget {
  const RankingPodium({super.key});

  @override
  Widget build(BuildContext context) {
    return Podium(
      firstPosition: Text("1"),
      secondPosition: Text("2"),
      thirdPosition: Text("3"),
      showRankingNumberInsteadOfText: true,
      color: AUColors.lightGreen,
      rankingTextColor: AUColors.white,
      rankingFontSize: 30.sp,
      height: 130.h,
      width: 80.w,
    );
  }
}
