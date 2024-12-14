import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class SensorChart extends StatelessWidget {
  const SensorChart({
    super.key,
    required this.min,
    required this.max,
    required this.current,
    required this.title,
    this.unit = "",
  });

  final double min;
  final double max;
  final double current;
  final String title;
  final String unit;

  String formatValue(double value) {
    // Format the sensor value as a string
    return "${value.toStringAsFixed(1)} $unit"; // 1 decimal place
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();

    // Calculate the percentage of the current value in relation to min/max
    double totalRange = max - min;
    double currentPercentage = (current - min) / totalRange * 100;

    // If current is below min or above max, cap the percentage at 0 or 100
    currentPercentage = currentPercentage.clamp(0.0, 100.0);

    late List<CircularStackEntry> data;

    // Create chart data based on the current value and range
    data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          // Show current range (used portion of the chart)
          CircularSegmentEntry(currentPercentage, AUColors.white,
              rankKey: 'Used'),

          // Show remaining range (unused portion of the chart)
          CircularSegmentEntry(100 - currentPercentage, AUColors.lightGreen,
              rankKey: 'Remaining'),
        ],
        rankKey: 'Sensor Range',
      ),
    ];

    return Center(
      child: Column(
        children: [
          AnimatedCircularChart(
            key: chartKey,
            size: Size(120.w, 120.w),
            initialChartData: data,
            holeLabel: formatValue(
              current,
            ), // Show current value in the middle of the chart
            labelStyle: TextStyle(
              color: AUColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AUColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          )
        ],
      ),
    );
  }
}
