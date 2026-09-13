import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class MessageStatusIcon extends StatelessWidget {
  final String status;

  const MessageStatusIcon({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'pending':
      case 'sending':
        return const Icon(
          Icons.access_time_rounded,
          size: 13,
          color: ColoursDark.onPrimary,
        );
      case 'sent':
        return const Icon(
          Icons.done_rounded,
          size: 14,
          color: ColoursDark.onPrimary,
        );
      case 'delivered':
        return const Icon(
          Icons.done_all_rounded,
          size: 14,
          color: ColoursDark.onPrimary,
        );
      case 'read':
        return const Icon(
          Icons.done_all_rounded,
          size: 14,
          color: ColoursDark.secondary,
        );
      case 'failed':
        return const Icon(
          Icons.error_outline_rounded,
          size: 14,
          color: ColoursDark.error,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
