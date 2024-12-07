import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_app/config/colors.dart';

class MainPageInfoWidget extends StatelessWidget {
  const MainPageInfoWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Duration time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      height: 100.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 10.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AUColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AUColors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: subtitle,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                          text: "${time.inMinutes}min",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(15 / 360),
            child: SvgPicture.asset(
              "assets/img/medicine-icon.svg",
              colorFilter: ColorFilter.mode(AUColors.white, BlendMode.srcIn),
              width: 70.sp,
            ),
          ),
        ],
      ),
    );
  }
}
