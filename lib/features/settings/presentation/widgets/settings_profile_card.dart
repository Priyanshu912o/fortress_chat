import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import '../../domain/entities/user_profile_entity.dart';

class SettingsProfileCard extends StatelessWidget {
  final UserProfileEntity? user;

  const SettingsProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ??
        (user?.email?.split('@')[0]) ??
        'Fortress User';
    final email = user?.email ?? 'No email associated';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: ColoursDark.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: ColoursDark.divider),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ColoursDark.primary.withValues(alpha: 0.2),
            backgroundImage:
                user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
            child: user?.photoUrl == null
                ? Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: ColoursDark.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    color: ColoursDark.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(
                    color: ColoursDark.onSurfaceMuted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ColoursDark.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadii.tag),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shield,
                        size: 12,
                        color: ColoursDark.secondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Fortress Protected',
                        style: TextStyle(
                          color: ColoursDark.secondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
