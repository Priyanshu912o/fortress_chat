import 'package:flutter/material.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../domain/entities/connection_entity.dart';

class ConnectionTile extends StatelessWidget {
  final ConnectionEntity connection;
  final VoidCallback onTap;

  const ConnectionTile({
    super.key,
    required this.connection,
    required this.onTap,
  });

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: ColoursDark.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: ColoursDark.divider.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            // Avatar with initials or image
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: ColoursDark.primary.withOpacity(0.2),
                  backgroundImage: connection.otherDpUrl != null
                      ? NetworkImage(connection.otherDpUrl!)
                      : null,
                  child: connection.otherDpUrl == null
                      ? Text(
                          _getInitials(connection.otherName),
                          style: const TextStyle(
                            color: ColoursDark.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            // Contact Name & Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    connection.otherName,
                    style: const TextStyle(
                      color: ColoursDark.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    connection.otherEmail,
                    style: const TextStyle(
                      color: ColoursDark.onSurfaceMuted,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Chat Icon Action
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs + 2),
              decoration: BoxDecoration(
                color: ColoursDark.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: ColoursDark.primary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
