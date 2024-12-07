import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class PodiumTile extends StatelessWidget {
  const PodiumTile({super.key, required this.name, required this.points});

  final String name;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AUColors.white,
            fontSize: 6.sp,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AUColors.lightGreen,
          ),
          child: Text(
            points.abs().toString(),
            style: TextStyle(
              color: AUColors.white,
              fontSize: 8.sp,
            ),
          ),
        ),
      ],
    );
  }
}
