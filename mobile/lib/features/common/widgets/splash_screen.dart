import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_app/config/colors.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Animation controller to control the opacity of the logo
    final animationController = useAnimationController(
      duration: const Duration(seconds: 4), // Duration of the animation
    );

    // Use an animation for opacity that goes from 0 to 1 (fade in)
    final opacity = useAnimation(Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    ));

    // Trigger the animation to start fading in after the splash screen is shown
    useEffect(() {
      animationController.forward();
      Future.delayed(const Duration(seconds: 5), () {
        // Navigate to the main page after 3 seconds
        Navigator.pushReplacementNamed(context, '/main-page');
      });
      return null; // Cleanup
    }, []);

    return Scaffold(
      backgroundColor: AUColors.white, // Set the splash screen background color
      body: Center(
        child: Opacity(
          opacity: opacity, // Apply the animation to the logo's opacity
          child: Image.asset(
            'assets/img/logo-vertical.png', // Replace with your logo image asset
            width: 150.w, // Adjust width as needed
            height: 150.h, // Adjust height as needed
          ),
        ),
      ),
    );
  }
}
