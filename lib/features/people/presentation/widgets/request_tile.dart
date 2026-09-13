import 'package:flutter/material.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../domain/entities/connection_entity.dart';

class RequestTile extends StatelessWidget {
  final ConnectionEntity connection;
  final bool isIncoming;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const RequestTile({
    super.key,
    required this.connection,
    required this.isIncoming,
    this.onAccept,
    this.onReject,
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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: ColoursDark.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: ColoursDark.divider.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: isIncoming
                    ? ColoursDark.primary.withOpacity(0.2)
                    : ColoursDark.surfaceVariant,
                backgroundImage: connection.otherDpUrl != null
                    ? NetworkImage(connection.otherDpUrl!)
                    : null,
                child: connection.otherDpUrl == null
                    ? Text(
                        _getInitials(connection.otherName),
                        style: TextStyle(
                          color: isIncoming
                              ? ColoursDark.primary
                              : ColoursDark.onSurfaceMuted,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
                      connection.otherName,
                      style: const TextStyle(
                        color: ColoursDark.onBackground,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
              if (!isIncoming)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: ColoursDark.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppRadii.tag),
                    border: Border.all(
                      color: ColoursDark.primary.withOpacity(0.3),
                    ),
                  ),
                  child: const Text(
                    'Pending',
                    style: TextStyle(
                      color: ColoursDark.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (isIncoming) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColoursDark.error,
                    side: BorderSide(color: ColoursDark.error.withOpacity(0.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                  ),
                  child: const Text('Decline'),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColoursDark.primary,
                    foregroundColor: ColoursDark.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
