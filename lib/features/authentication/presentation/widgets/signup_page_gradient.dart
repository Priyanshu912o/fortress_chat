import 'package:flutter/material.dart';
import 'package:temp/features/authentication/presentation/widgets/circle.dart';

class CircleGradient extends StatelessWidget {
  const CircleGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Purple glow circle
                Positioned(
                  left: 80,
                  top: 60,
                  child: BlurredCircle(
                    size: 130,
                    color: Theme.of(context).colorScheme.primary,
                    blurRadius: 200,
                  ),
                ),
                // Green glow circle
                Positioned(
                  right: 50,
                  bottom: 80,
                  child: const BlurredCircle(
                    size: 80,
                    color:  Color.fromARGB(255, 145, 223, 148),
                    blurRadius: 200,
                  ),
                ),
              ],
            ),
          );
  }
}