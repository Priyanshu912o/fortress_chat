import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import '../../../messaging/domain/entities/message_entity.dart';

class SearchResultMessageTile extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback onTap;

  const SearchResultMessageTile({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 3,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: ColoursDark.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
              color: ColoursDark.divider.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColoursDark.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.message_rounded,
                  size: 16,
                  color: ColoursDark.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message.senderName ??
                              (message.isMe ? 'You' : 'Message'),
                          style: const TextStyle(
                            color: ColoursDark.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          timeago.format(message.sentAt, locale: 'en_short'),
                          style: const TextStyle(
                            color: ColoursDark.onSurfaceMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message.body,
                      style: const TextStyle(
                        color: ColoursDark.onBackground,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
