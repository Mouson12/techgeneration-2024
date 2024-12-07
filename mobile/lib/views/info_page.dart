import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/constants/sizes.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:office_app/features/languages/cubit/language_cubit.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AUColors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: AUSizes.mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 140.sp,
                  child: Image.asset("assets/img/alt-main-logo.png"),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                height: 32.h,
                child: LiteRollingSwitch(
                  onTap: () {},
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onChanged: (p0) {
                    context.read<LanguageCubit>().switchLanguage();
                  },
                  textOn: "PL",
                  colorOn: AUColors.mainGreen,
                  colorOff: AUColors.mainGreen,
                  textOff: "EN",
                  textOnColor: AUColors.white,
                  textOffColor: AUColors.white,
                  iconOn: Icons.south_america,
                  iconOff: Icons.south_america,
                  width: 90.w,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
