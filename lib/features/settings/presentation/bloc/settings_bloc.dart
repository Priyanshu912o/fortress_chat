import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/clear_local_cache_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final ClearLocalCacheUsecase _clearLocalCacheUsecase;
  final SignOutUsecase _signOutUsecase;

  SettingsBloc(
    this._getCurrentUserUsecase,
    this._clearLocalCacheUsecase,
    this._signOutUsecase,
  ) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleNotifications>(_onToggleNotifications);
    on<ToggleReadReceipts>(_onToggleReadReceipts);
    on<ToggleLastSeen>(_onToggleLastSeen);
    on<ClearLocalCacheEvent>(_onClearLocalCache);
    on<SignOutRequestedEvent>(_onSignOutRequested);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    final result = await _getCurrentUserUsecase();
    result.fold(
      (failure) => null,
      (user) => emit(state.copyWith(currentUser: user)),
    );
  }

  void _onToggleNotifications(
      ToggleNotifications event, Emitter<SettingsState> emit) {
    emit(state.copyWith(notificationsEnabled: event.enabled));
  }

  void _onToggleReadReceipts(
      ToggleReadReceipts event, Emitter<SettingsState> emit) {
    emit(state.copyWith(readReceiptsEnabled: event.enabled));
  }

  void _onToggleLastSeen(ToggleLastSeen event, Emitter<SettingsState> emit) {
    emit(state.copyWith(lastSeenEnabled: event.enabled));
  }

  Future<void> _onClearLocalCache(
      ClearLocalCacheEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isClearingCache: true));
    final result = await _clearLocalCacheUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        isClearingCache: false,
        message: 'Failed to clear cache: ${failure.message}',
      )),
      (_) => emit(state.copyWith(
        isClearingCache: false,
        message: 'Offline cache cleared successfully.',
      )),
    );
  }

  Future<void> _onSignOutRequested(
      SignOutRequestedEvent event, Emitter<SettingsState> emit) async {
    final result = await _signOutUsecase();
    result.fold(
      (failure) => emit(state.copyWith(
        message: 'Sign out failed: ${failure.message}',
      )),
      (_) => emit(state.copyWith(signedOut: true)),
    );
  }
}
