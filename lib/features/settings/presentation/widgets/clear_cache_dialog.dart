import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class ClearCacheDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ClearCacheDialog({
    super.key,
    required this.onConfirm,
  });

  static Future<void> show(BuildContext context, {required VoidCallback onConfirm}) {
    return showDialog(
      context: context,
      builder: (_) => ClearCacheDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColoursDark.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      title: const Text(
        'Clear Local Cache?',
        style: TextStyle(color: ColoursDark.onBackground),
      ),
      content: const Text(
        'This will erase all cached messages, chat rooms, and contacts from this device. Fresh data will reload from the server when connected.',
        style: TextStyle(color: ColoursDark.onSurfaceMuted),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ColoursDark.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Clear Cache'),
        ),
      ],
    );
  }
}
