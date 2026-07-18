import 'package:flutter/material.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/circle.dart';

class CircleGradient extends StatelessWidget {
  const CircleGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentGeometry.center,
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
              color: Color.fromARGB(255, 145, 223, 148),
              blurRadius: 200,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadii.medium,
                  boxShadow: AppElevation.shadowSmall,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Icon(
                    Icons.shield,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space8,
                ),
                child: Text(
                  'Create account',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Text(
                'join Fortress and secure your digital \n communications.',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  wordSpacing: AppSpacing.space2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
