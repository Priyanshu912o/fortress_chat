import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/colours_dark.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;

  const SettingsCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColoursDark.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
        side: const BorderSide(color: ColoursDark.divider),
      ),
      child: child,
    );
  }
}
