import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color borderColor;
  final double borderWidth;

  const CircleImageWidget({
    super.key,
    required this.imageUrl,
    this.size = 50.0,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + borderWidth * 2,
      height: size + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: borderColor, // Border color
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
