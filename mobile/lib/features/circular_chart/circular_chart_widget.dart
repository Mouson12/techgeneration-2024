import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class CircularChartWidget extends StatelessWidget {
  const CircularChartWidget({
    super.key,
    required this.totalDuration,
    required this.elapsedDuration,
    required this.remainingDuration,
  });

  final Duration totalDuration;
  final Duration elapsedDuration;
  final Duration remainingDuration;

  String formatDuration(Duration duration) {
    // Convert Duration to a formatted string (e.g., "HH:MM h")
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr h';
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();

    late List<CircularStackEntry> data;

    if (remainingDuration.isNegative) {
      // If invalid or overdue
      data = <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(1, AUColors.error, rankKey: 'Overdue'),
          ],
          rankKey: 'Dose Time',
        ),
      ];
    } else {
      final double elapsedMinutes = elapsedDuration.inMinutes.toDouble();
      final double remainingMinutes = remainingDuration.inMinutes.toDouble();

      data = <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(elapsedMinutes, AUColors.lightGreen,
                rankKey: 'Elapsed'),
            CircularSegmentEntry(remainingMinutes, AUColors.darkGreen,
                rankKey: 'Remaining'),
          ],
          rankKey: 'Dose Time',
        ),
      ];
    }

    return Center(
      child: AnimatedCircularChart(
        key: chartKey,
        size: Size(120.w, 120.w),
        initialChartData: data,
        holeLabel: formatDuration(
          remainingDuration.isNegative
              ? Duration.zero
              : remainingDuration, // Display remaining or 0
        ),
        labelStyle: TextStyle(
          color: AUColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
