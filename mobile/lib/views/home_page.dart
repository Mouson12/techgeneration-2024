import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/common/widgets/loading_screen.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/constants/sizes.dart';
import 'package:office_app/config/l10n/extensions.dart';
import 'package:office_app/features/circular_chart/circular_chart_widget.dart';
import 'package:office_app/features/common/widgets/circle_image_widget.dart';
import 'package:office_app/features/data/cubit/alarm_cubit.dart';
import 'package:office_app/features/data/cubit/medication_cubit.dart';
import 'package:office_app/features/main_page_info_widget/main_page_info_widget.dart';
import 'package:http/http.dart' as http; // For making HTTP requests

bool wasLoaded = false;

class HomePage extends HookWidget {
  const HomePage({super.key});

  static final headerStyle = TextStyle(
    color: AUColors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  void sendAlarmCancel() async {
    try {
      // Define the payload
      final payload = json.encode({'fall_detected': false});

      // Make the POST request
      final response = await http.post(
        Uri.parse('http://192.168.163.182:5002/api/alarm'),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      print(response);
    } catch (e) {
      // Handle any errors that occur during the HTTP request
    }
  }

  @override
  Widget build(BuildContext context) {
    final alarmState = context.watch<AlarmCubit>().state;
    // Logic to determine overdue status and chart durations

    return Scaffold(
      backgroundColor: AUColors.white,
      body: Padding(
        padding: AUSizes.mainPadding,
        child: BlocBuilder<MedicationCubit, MedicationState>(
          builder: (context, state) {
            final DateTime now = DateTime.now();
            if (state is! MedicationLoaded) {
              return LoadingScreen(
                bgColor: AUColors.white,
                loadingColor: AUColors.mainGreen,
              );
            }

            final DateTime targetTime = state.medication.nextDose;
            final DateTime lastDose = state.medication.lastDose;

            final Duration totalDuration = targetTime.difference(lastDose);
            final Duration elapsedDuration = now.difference(lastDose);
            final Duration remainingDuration = targetTime.difference(now);
            print(targetTime);
            print(remainingDuration);
            print("Now: $now");
            // final Duration safeElapsedDuration =
            //     elapsedDuration.isNegative ? Duration.zero : elapsedDuration;
            // final Duration safeRemainingDuration = remainingDuration.isNegative
            //     ? Duration.zero
            //     : remainingDuration;

            final bool isOverdue = remainingDuration.isNegative;
            print(isOverdue);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.text.homePageWelcomeText("Francesco"),
                      style: headerStyle,
                    ),
                    CircleImageWidget(
                      imageUrl: "assets/img/person.jpg",
                      size: 40.sp,
                    )
                  ],
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
                if (alarmState is AlarmLoaded && alarmState.alert.isDanger)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        sendAlarmCancel();
                        context.read<AlarmCubit>().loadData();
                      },
                      child: Container(
                        width: 100.w,
                        margin: EdgeInsets.only(top: 40.h),
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // Background color, set transparent if you only want the border
                          border: Border.all(
                            color: AUColors.error, // Red border color
                            width: 2.0, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                        ),
                        child: Center(
                          child: Text(
                            "Alarm",
                            style: TextStyle(
                              color: AUColors.error, // Text color
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Center(
                //   child: TextButton(
                //     onPressed: () async {
                //       sendAlarm();
                //     },
                //     child: Text("Alarm"),
                //     style: ButtonStyle(),
                //   ),
                // ),
                // Bottom stats section
                // const AlarmHeader(),
              ],
            );
          },
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
