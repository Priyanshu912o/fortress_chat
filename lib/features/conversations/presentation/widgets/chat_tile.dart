import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../domain/entities/chat_room.dart';

class ChatTile extends StatelessWidget {
  final ChatRoom room;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.room,
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
    final title = room.displayName;
    final lastMessage = room.lastMessageBody ?? 'Tap to start conversation';
    final timeStr = room.lastMessageAt != null
        ? timeago.format(room.lastMessageAt!, locale: 'en_short')
        : '';
    final hasUnread = room.unreadCount > 0;

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
          border: Border.all(
            color: hasUnread
                ? ColoursDark.primary.withOpacity(0.3)
                : ColoursDark.divider.withOpacity(0.4),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: room.isDirect
                      ? ColoursDark.primary.withOpacity(0.2)
                      : ColoursDark.secondary.withOpacity(0.2),
                  backgroundImage: room.isDirect && room.otherUserDpUrl != null
                      ? NetworkImage(room.otherUserDpUrl!)
                      : (!room.isDirect && room.groupDpUrl != null
                          ? NetworkImage(room.groupDpUrl!)
                          : null),
                  child: (room.isDirect && room.otherUserDpUrl == null)
                      ? Text(
                          _getInitials(title),
                          style: const TextStyle(
                            color: ColoursDark.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : (!room.isDirect && room.groupDpUrl == null
                          ? const Icon(
                              Icons.groups_rounded,
                              color: ColoursDark.secondary,
                              size: 24,
                            )
                          : null),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            // Title and last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: ColoursDark.onBackground,
                            fontWeight:
                                hasUnread ? FontWeight.bold : FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (timeStr.isNotEmpty)
                        Text(
                          timeStr,
                          style: TextStyle(
                            color: hasUnread
                                ? ColoursDark.primary
                                : ColoursDark.onSurfaceMuted,
                            fontSize: 12,
                            fontWeight: hasUnread
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            color: hasUnread
                                ? ColoursDark.onBackground
                                : ColoursDark.onSurfaceMuted,
                            fontSize: 13,
                            fontWeight: hasUnread
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ColoursDark.tertiary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${room.unreadCount}',
                            style: const TextStyle(
                              color: ColoursDark.onTertiary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
