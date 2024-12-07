import 'package:flutter/material.dart';
import 'package:office_app/config/colors.dart';
import 'package:office_app/views/home_page.dart';
import 'package:office_app/views/info_page.dart';
import 'package:office_app/views/ranking_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const RankingPage(),
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
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style13,
      backgroundColor: AUColors.mainGreen,
    );
  }
}
