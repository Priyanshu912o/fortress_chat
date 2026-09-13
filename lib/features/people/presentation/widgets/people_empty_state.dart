import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class PeopleEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PeopleEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: ColoursDark.surfaceVariant.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: ColoursDark.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: const TextStyle(
                color: ColoursDark.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColoursDark.onSurfaceMuted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
