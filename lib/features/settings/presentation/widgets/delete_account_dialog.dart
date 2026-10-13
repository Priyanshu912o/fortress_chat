import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteAccountDialog({
    super.key,
    required this.onConfirm,
  });

  static Future<void> show(BuildContext context, {required VoidCallback onConfirm}) {
    return showDialog(
      context: context,
      builder: (_) => DeleteAccountDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColoursDark.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      title: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: ColoursDark.error),
          SizedBox(width: 8),
          Text(
            'Delete Account?',
            style: TextStyle(color: ColoursDark.onBackground),
          ),
        ],
      ),
      content: const Text(
        'This will permanently delete your account from Firebase and the server. Your chat history will remain visible to your contacts as "Deleted Account", but your name, profile, and local data will be erased.',
        style: TextStyle(color: ColoursDark.onSurfaceMuted, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ColoursDark.error,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Delete Account'),
        ),
      ],
    );
  }
}
