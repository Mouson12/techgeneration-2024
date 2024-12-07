import 'package:flutter/material.dart';
import 'package:office_app/config/colors.dart';

class ALProgressIndicator extends StatelessWidget {
  const ALProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 110,
        width: 200,
        child: Center(
          child: CircularProgressIndicator(color: AUColors.mainGreen),
        ),
      ),
    );
  }
}
