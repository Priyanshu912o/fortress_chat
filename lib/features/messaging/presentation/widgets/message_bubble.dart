import 'package:flutter/material.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/colours_dark.dart';
import '../../domain/entities/message_entity.dart';
import 'message_status_icon.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool showSenderName;

  const MessageBubble({
    super.key,
    required this.message,
    this.showSenderName = false,
  });

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 3,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: isMe ? AppGradients.primary : null,
          color: isMe ? null : ColoursDark.surfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadii.card),
            topRight: const Radius.circular(AppRadii.card),
            bottomLeft: Radius.circular(isMe ? AppRadii.card : 4),
            bottomRight: Radius.circular(isMe ? 4 : AppRadii.card),
          ),
          boxShadow: isMe
              ? [
                  BoxShadow(
                    color: ColoursDark.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe && showSenderName && message.senderName != null) ...[
              Text(
                message.senderName!,
                style: const TextStyle(
                  color: ColoursDark.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
            ],
            Text(
              message.body,
              style: TextStyle(
                color: isMe ? ColoursDark.onPrimary : ColoursDark.onBackground,
                fontSize: 15,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.sentAt),
                  style: TextStyle(
                    color: isMe
                        ? ColoursDark.onPrimary.withOpacity(0.7)
                        : ColoursDark.onSurfaceMuted,
                    fontSize: 11,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  MessageStatusIcon(status: message.status),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
