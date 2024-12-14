import 'package:flutter/material.dart';
import 'package:office_app/config/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(
      {super.key, required this.bgColor, required this.loadingColor});

  final Color bgColor;
  final Color loadingColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: CircularProgressIndicator(
          color: AUColors.mainGreen,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
