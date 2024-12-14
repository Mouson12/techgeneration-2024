import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/common/widgets/loading_screen.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/config/constants/sizes.dart';
import 'package:office_app/features/data/cubit/sensor_cubit.dart';
import 'package:office_app/features/sensors/widgets/sensor_chart.dart';

class StatsPage extends HookWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AUColors.mainGreen,
      body: Padding(
        padding: AUSizes.mainPadding,
        child: BlocBuilder<SensorCubit, SensorState>(
          builder: (context, state) {
            if (state is! SensorLoaded) {
              return LoadingScreen(
                bgColor: AUColors.mainGreen,
                loadingColor: AUColors.white,
              );
            }
            final sensors = state.sensors;
            return Column(
              children: [
                SensorChart(
                  min: 20,
                  max: 50,
                  current: sensors["temperature"]?.value ?? 0.0,
                  title: "Temperature",
                  unit: "C",
                ),
                SizedBox(height: 20.h),
                SensorChart(
                  min: 50,
                  max: 150,
                  current: sensors["pulsometer"]?.value ?? 0.0,
                  title: "Pulsometer",
                  unit: "bpm",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
