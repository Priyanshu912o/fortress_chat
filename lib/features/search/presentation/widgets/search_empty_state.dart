import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class SearchEmptyState extends StatelessWidget {
  final String? query;

  const SearchEmptyState({
    super.key,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    if (query == null || query!.isEmpty) {
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
                child: const Icon(
                  Icons.search_rounded,
                  size: 48,
                  color: ColoursDark.onSurfaceMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Global Fortress Search',
                style: TextStyle(
                  color: ColoursDark.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Find messages, chat rooms, and verified contacts instantly in offline storage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColoursDark.onSurfaceMuted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: ColoursDark.onSurfaceMuted,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No results for "$query"',
              style: const TextStyle(
                color: ColoursDark.onBackground,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Check spelling or try a different search keyword.',
              style: TextStyle(
                color: ColoursDark.onSurfaceMuted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
