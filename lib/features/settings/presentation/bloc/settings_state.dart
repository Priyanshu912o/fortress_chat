import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile_entity.dart';

class SettingsState extends Equatable {
  final UserProfileEntity? currentUser;
  final bool notificationsEnabled;
  final bool readReceiptsEnabled;
  final bool lastSeenEnabled;
  final bool isClearingCache;
  final String? message;
  final bool signedOut;

  const SettingsState({
    this.currentUser,
    this.notificationsEnabled = true,
    this.readReceiptsEnabled = true,
    this.lastSeenEnabled = true,
    this.isClearingCache = false,
    this.message,
    this.signedOut = false,
  });

  SettingsState copyWith({
    UserProfileEntity? currentUser,
    bool? notificationsEnabled,
    bool? readReceiptsEnabled,
    bool? lastSeenEnabled,
    bool? isClearingCache,
    String? message,
    bool? signedOut,
    bool clearMessage = false,
  }) {
    return SettingsState(
      currentUser: currentUser ?? this.currentUser,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      readReceiptsEnabled: readReceiptsEnabled ?? this.readReceiptsEnabled,
      lastSeenEnabled: lastSeenEnabled ?? this.lastSeenEnabled,
      isClearingCache: isClearingCache ?? this.isClearingCache,
      message: clearMessage ? null : (message ?? this.message),
      signedOut: signedOut ?? this.signedOut,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        notificationsEnabled,
        readReceiptsEnabled,
        lastSeenEnabled,
        isClearingCache,
        message,
        signedOut,
      ];
}
