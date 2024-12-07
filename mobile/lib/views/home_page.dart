import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/constants/sizes.dart';
import 'package:office_app/config/l10n/extensions.dart';
import 'package:office_app/features/alarm/widgets/alarm_header.dart';
import 'package:office_app/features/circular_chart/circular_chart_widget.dart';
import 'package:office_app/features/main_page_info_widget/main_page_info_widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  static final headerStyle = TextStyle(
    color: AUColors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final DateTime targetTime =
        DateTime(2024, 12, 7, 12, 30); // Example target time
    final DateTime lastDose =
        DateTime(2024, 12, 7, 10, 30); // Example last dose time
    final DateTime now = DateTime.now().add(const Duration(hours: 1));

    // Logic to determine overdue status and chart durations
    final Duration totalDuration = targetTime.difference(lastDose);
    final Duration elapsedDuration = now.difference(lastDose);
    final Duration remainingDuration = targetTime.difference(now);

    final bool isOverdue = remainingDuration.isNegative;

    return Scaffold(
      backgroundColor: AUColors.white,
      body: Padding(
        padding: AUSizes.mainPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text
            Text(
              context.text.homePageWelcomeText("Francesco"),
              style: headerStyle,
            ),
            // Top section: Meds info
            buildMainPageInfo(
              context,
              !isOverdue,
              isOverdue
                  ? elapsedDuration.abs() // Show time overdue
                  : remainingDuration, // Show time left
            ),
            Text(
              context.text.homePageTodaySession,
              style: headerStyle,
            ),
            SizedBox(height: 15.h),
            // Circular chart widget
            CircularChartWidget(
              totalDuration: totalDuration,
              elapsedDuration:
                  elapsedDuration, // Ensure no negative elapsed time
              remainingDuration:
                  remainingDuration, // Ensure no negative remaining time
            ),
            // Bottom stats section
            const AlarmHeader(),
          ],
        ),
      ),
    );
  }

  Widget buildMainPageInfo(
      BuildContext context, bool areMedsTaken, Duration time) {
    if (areMedsTaken) {
      return MainPageInfoWidget(
        title: context.text.takenMeds,
        subtitle: context.text.nextDose,
        time: time,
        color: AUColors.mainGreen,
      );
    }

    return MainPageInfoWidget(
      title: context.text.medsToTake,
      subtitle: context.text.lateDose,
      time: time,
      color: AUColors.error,
    );
  }
}
