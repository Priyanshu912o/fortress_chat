import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import '../../../people/domain/entities/connection_entity.dart';

class SelectableContactTile extends StatelessWidget {
  final ConnectionEntity contact;
  final bool isSelected;
  final bool isGroupMode;
  final VoidCallback onTap;

  const SelectableContactTile({
    super.key,
    required this.contact,
    required this.isSelected,
    required this.isGroupMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: 2,
        ),
        leading: CircleAvatar(
          backgroundColor: ColoursDark.primary.withValues(alpha: 0.2),
          backgroundImage: contact.otherDpUrl != null
              ? NetworkImage(contact.otherDpUrl!)
              : null,
          child: contact.otherDpUrl == null
              ? Text(
                  contact.otherName.isNotEmpty
                      ? contact.otherName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: ColoursDark.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        title: Text(
          contact.otherName,
          style: const TextStyle(
            color: ColoursDark.onBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          contact.otherEmail,
          style: const TextStyle(
            color: ColoursDark.onSurfaceMuted,
            fontSize: 12,
          ),
        ),
        trailing: isGroupMode
            ? Checkbox(
                value: isSelected,
                activeColor: ColoursDark.primary,
                checkColor: ColoursDark.onPrimary,
                onChanged: (_) => onTap(),
              )
            : const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: ColoursDark.onSurfaceMuted,
              ),
        onTap: onTap,
      ),
    );
  }
}
