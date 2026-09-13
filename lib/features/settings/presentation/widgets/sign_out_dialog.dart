import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SignOutDialog({
    super.key,
    required this.onConfirm,
  });

  static Future<void> show(BuildContext context, {required VoidCallback onConfirm}) {
    return showDialog(
      context: context,
      builder: (_) => SignOutDialog(onConfirm: onConfirm),
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
        'Sign Out?',
        style: TextStyle(color: ColoursDark.onBackground),
      ),
      content: const Text(
        'Are you sure you want to sign out of Fortress?',
        style: TextStyle(color: ColoursDark.onSurfaceMuted),
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
          child: const Text('Sign Out'),
        ),
      ],
    );
  }
}
