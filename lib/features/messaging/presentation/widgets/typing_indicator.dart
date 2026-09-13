import 'package:flutter/material.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: ColoursDark.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'typing',
            style: TextStyle(
              color: ColoursDark.onSurfaceMuted,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          TypingDot(controller: _controller, index: 0),
          TypingDot(controller: _controller, index: 1),
          TypingDot(controller: _controller, index: 2),
        ],
      ),
    );
  }
}

class TypingDot extends StatelessWidget {
  final Animation<double> controller;
  final int index;

  const TypingDot({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = (controller.value - (index * 0.2)) % 1.0;
        final scale = 0.6 + 0.4 * (1.0 - (progress - 0.5).abs() * 2);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 7 * scale,
          height: 7 * scale,
          decoration: BoxDecoration(
            color: ColoursDark.primary
                .withValues(alpha: (0.4 + 0.6 * scale).clamp(0.0, 1.0)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
