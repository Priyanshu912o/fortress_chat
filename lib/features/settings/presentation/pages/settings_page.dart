import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/core/theme/colours_dark.dart';
import 'package:Fortress/injection.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/clear_cache_dialog.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_profile_card.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/sign_out_dialog.dart';
import '../widgets/delete_account_dialog.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsBloc>()..add(const LoadSettings()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.signedOut) {
          context.go('/auth/login');
        } else if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: ColoursDark.surfaceVariant,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColoursDark.background,
          appBar: AppBar(
            backgroundColor: ColoursDark.background,
            elevation: 0,
            title: const Text(
              'Settings',
              style: TextStyle(
                color: ColoursDark.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              // User Profile Header
              SettingsProfileCard(user: state.currentUser),

              const SizedBox(height: AppSpacing.lg),

              // Privacy & Security Section
              const SettingsSectionTitle(title: 'PRIVACY & SECURITY'),
              SettingsCard(
                child: Column(
                  children: [
                    SwitchListTile(
                      value: state.readReceiptsEnabled,
                      activeThumbColor: ColoursDark.primary,
                      title: const Text(
                        'Read Receipts',
                        style: TextStyle(color: ColoursDark.onBackground),
                      ),
                      subtitle: const Text(
                        'If turned off, you won\'t see or send read receipts',
                        style: TextStyle(
                            color: ColoursDark.onSurfaceMuted, fontSize: 12),
                      ),
                      onChanged: (val) => context
                          .read<SettingsBloc>()
                          .add(ToggleReadReceipts(val)),
                    ),
                    const Divider(color: ColoursDark.divider, height: 1),
                    SwitchListTile(
                      value: state.lastSeenEnabled,
                      activeThumbColor: ColoursDark.primary,
                      title: const Text(
                        'Last Seen & Online Presence',
                        style: TextStyle(color: ColoursDark.onBackground),
                      ),
                      subtitle: const Text(
                        'Broadcast online status to accepted contacts',
                        style: TextStyle(
                            color: ColoursDark.onSurfaceMuted, fontSize: 12),
                      ),
                      onChanged: (val) =>
                          context.read<SettingsBloc>().add(ToggleLastSeen(val)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Notifications Section
              const SettingsSectionTitle(title: 'NOTIFICATIONS'),
              SettingsCard(
                child: SwitchListTile(
                  value: state.notificationsEnabled,
                  activeThumbColor: ColoursDark.primary,
                  title: const Text(
                    'Push Notifications',
                    style: TextStyle(color: ColoursDark.onBackground),
                  ),
                  subtitle: const Text(
                    'Receive message alerts and connection requests',
                    style: TextStyle(
                        color: ColoursDark.onSurfaceMuted, fontSize: 12),
                  ),
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(ToggleNotifications(val)),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Storage & Cache
              const SettingsSectionTitle(title: 'STORAGE & DATA'),
              SettingsCard(
                child: ListTile(
                  leading: const Icon(Icons.storage_rounded,
                      color: ColoursDark.primary),
                  title: const Text(
                    'Clear Offline Cache',
                    style: TextStyle(color: ColoursDark.onBackground),
                  ),
                  subtitle: const Text(
                    'Clear local Drift SQLite cache',
                    style: TextStyle(
                        color: ColoursDark.onSurfaceMuted, fontSize: 12),
                  ),
                  trailing: state.isClearingCache
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.arrow_forward_ios,
                          size: 14, color: ColoursDark.onSurfaceMuted),
                  onTap: () => ClearCacheDialog.show(
                    context,
                    onConfirm: () => context
                        .read<SettingsBloc>()
                        .add(const ClearLocalCacheEvent()),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Account & Sign Out
              const SettingsSectionTitle(title: 'ACCOUNT'),
              SettingsCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout_rounded,
                          color: ColoursDark.onBackground),
                      title: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: ColoursDark.onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Log out of your Fortress account',
                        style: TextStyle(
                            color: ColoursDark.onSurfaceMuted, fontSize: 12),
                      ),
                      onTap: () => SignOutDialog.show(
                        context,
                        onConfirm: () => context
                            .read<SettingsBloc>()
                            .add(const SignOutRequestedEvent()),
                      ),
                    ),
                    const Divider(color: ColoursDark.divider, height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete_forever_rounded,
                          color: ColoursDark.error),
                      title: const Text(
                        'Delete Account & Reset',
                        style: TextStyle(
                          color: ColoursDark.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Erase profile & cache, retain chats for contacts',
                        style: TextStyle(
                            color: ColoursDark.onSurfaceMuted, fontSize: 12),
                      ),
                      trailing: state.isClearingCache
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.arrow_forward_ios,
                              size: 14, color: ColoursDark.onSurfaceMuted),
                      onTap: () => DeleteAccountDialog.show(
                        context,
                        onConfirm: () => context
                            .read<SettingsBloc>()
                            .add(const DeleteAccountRequestedEvent()),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Version Info Footer
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 28,
                      color: ColoursDark.onSurfaceMuted,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'Fortress Secure Chat',
                      style: TextStyle(
                        color: ColoursDark.onSurfaceMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Version 1.0.0 (Offline-First)',
                      style: TextStyle(
                        color: ColoursDark.onSurfaceMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
    );
  }
}
