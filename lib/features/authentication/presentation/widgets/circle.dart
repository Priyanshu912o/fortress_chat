import 'package:flutter/material.dart';

class BlurredCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double blurRadius;

  const BlurredCircle({
    super.key,
    required this.size,
    required this.color,
    required this.blurRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.01),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.7),
            blurRadius: blurRadius,
            spreadRadius: blurRadius / 2,
          ),
        ],
      ),
    );
  }
}
