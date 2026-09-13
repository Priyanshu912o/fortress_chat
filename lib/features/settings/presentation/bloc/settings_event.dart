import 'package:equatable/equatable.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;
  const ToggleNotifications(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ToggleReadReceipts extends SettingsEvent {
  final bool enabled;
  const ToggleReadReceipts(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ToggleLastSeen extends SettingsEvent {
  final bool enabled;
  const ToggleLastSeen(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ClearLocalCacheEvent extends SettingsEvent {
  const ClearLocalCacheEvent();
}

class SignOutRequestedEvent extends SettingsEvent {
  const SignOutRequestedEvent();
}
