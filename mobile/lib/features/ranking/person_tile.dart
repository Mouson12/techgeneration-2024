import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/l10n/extensions.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({
    super.key,
    required this.position,
    required this.name,
    required this.points,
  });

  final int position;
  final String name;
  final int points;

  @override
  Widget build(BuildContext context) {
    Image badge = Image.asset("assets/img/first-place.png");
    if (position == 2) {
      badge = Image.asset("assets/img/second-place.png");
    }
    if (position == 3) {
      badge = Image.asset("assets/img/third-place.png");
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Center(
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AUColors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      position.toString(),
                      style: TextStyle(
                        color: AUColors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$points " + context.text.points,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          position < 4
              ? SizedBox(
                  height: 22.w,
                  child: badge,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
