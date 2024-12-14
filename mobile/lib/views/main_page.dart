import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/features/data/cubit/alarm_cubit.dart';
import 'package:office_app/features/data/cubit/medication_cubit.dart';
import 'package:office_app/features/data/cubit/sensor_cubit.dart';
import 'package:office_app/views/home_page.dart';
import 'package:office_app/views/info_page.dart';
import 'package:office_app/views/stats_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void _startPeriodicReload(BuildContext context) {
    // Start a timer to call reloadData every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (timer) {
      context.read<MedicationCubit>().reloadData();
    });
  }

  void _startAlarmPeriodicReload(BuildContext context) {
    // Start a timer to call reloadData every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (timer) {
      context.read<AlarmCubit>().loadData();
    });
  }

  void _startSensorPeriodicReload(BuildContext context) {
    // Start a timer to call reloadData every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (timer) {
      context.read<SensorCubit>().reloadData();
    });
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const StatsPage(),
      const InfoPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AUColors.white,
        inactiveColorPrimary: AUColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.equalizer),
        title: ("Settings"),
        activeColorPrimary: AUColors.white,
        inactiveColorPrimary: AUColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.info),
        title: ("Info"),
        activeColorPrimary: AUColors.white,
        inactiveColorPrimary: AUColors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _startPeriodicReload(context);
    _startSensorPeriodicReload(context);
    _startAlarmPeriodicReload(context);

    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style13,
      backgroundColor: AUColors.mainGreen,
    );
  }
}
