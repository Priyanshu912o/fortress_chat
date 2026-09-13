import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/accept_connection_request_usecase.dart';
import '../../domain/use_cases/reject_connection_request_usecase.dart';
import '../../domain/use_cases/search_user_by_email_usecase.dart';
import '../../domain/use_cases/send_connection_request_usecase.dart';
import '../../domain/use_cases/sync_connections_usecase.dart';
import '../../domain/use_cases/watch_accepted_connections_usecase.dart';
import '../../domain/use_cases/watch_pending_requests_usecase.dart';
import '../../domain/use_cases/watch_sent_requests_usecase.dart';
import 'people_event.dart';
import 'people_state.dart';

@injectable
class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final WatchAcceptedConnectionsUsecase _watchAccepted;
  final WatchPendingRequestsUsecase _watchPending;
  final WatchSentRequestsUsecase _watchSent;
  final SearchUserByEmailUsecase _searchUser;
  final SendConnectionRequestUsecase _sendRequest;
  final AcceptConnectionRequestUsecase _acceptRequest;
  final RejectConnectionRequestUsecase _rejectRequest;
  final SyncConnectionsUsecase _syncConnections;

  StreamSubscription? _acceptedSub;
  StreamSubscription? _pendingSub;
  StreamSubscription? _sentSub;

  PeopleBloc(
    this._watchAccepted,
    this._watchPending,
    this._watchSent,
    this._searchUser,
    this._sendRequest,
    this._acceptRequest,
    this._rejectRequest,
    this._syncConnections,
  ) : super(const PeopleState()) {
    on<LoadPeople>(_onLoadPeople);
    on<RefreshPeople>(_onRefreshPeople);
    on<SearchUserEvent>(_onSearchUser);
    on<ClearSearchEvent>(_onClearSearch);
    on<SendRequestEvent>(_onSendRequest);
    on<AcceptRequestEvent>(_onAcceptRequest);
    on<RejectRequestEvent>(_onRejectRequest);
    on<AcceptedConnectionsUpdated>(_onAcceptedUpdated);
    on<PendingRequestsUpdated>(_onPendingUpdated);
    on<SentRequestsUpdated>(_onSentUpdated);
  }

  void _onLoadPeople(LoadPeople event, Emitter<PeopleState> emit) {
    emit(state.copyWith(isLoading: true));

    _acceptedSub?.cancel();
    _acceptedSub = _watchAccepted().listen((list) {
      add(AcceptedConnectionsUpdated(list));
    });

    _pendingSub?.cancel();
    _pendingSub = _watchPending().listen((list) {
      add(PendingRequestsUpdated(list));
    });

    _sentSub?.cancel();
    _sentSub = _watchSent().listen((list) {
      add(SentRequestsUpdated(list));
    });

    // Background sync from remote API
    _syncConnections().then((_) {});

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onRefreshPeople(RefreshPeople event, Emitter<PeopleState> emit) async {
    final result = await _syncConnections();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => null,
    );
  }

  void _onAcceptedUpdated(
      AcceptedConnectionsUpdated event, Emitter<PeopleState> emit) {
    emit(state.copyWith(accepted: event.list));
  }

  void _onPendingUpdated(
      PendingRequestsUpdated event, Emitter<PeopleState> emit) {
    emit(state.copyWith(pendingIncoming: event.list));
  }

  void _onSentUpdated(
      SentRequestsUpdated event, Emitter<PeopleState> emit) {
    emit(state.copyWith(sentOutgoing: event.list));
  }

  Future<void> _onSearchUser(
      SearchUserEvent event, Emitter<PeopleState> emit) async {
    if (event.email.trim().isEmpty) return;
    emit(state.copyWith(isSearching: true, clearMessages: true));

    final result = await _searchUser(event.email.trim());
    result.fold(
      (failure) => emit(state.copyWith(
        isSearching: false,
        errorMessage: failure.message,
      )),
      (users) => emit(state.copyWith(
        isSearching: false,
        searchResults: users,
      )),
    );
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<PeopleState> emit) {
    emit(state.copyWith(clearSearch: true, isSearching: false));
  }

  Future<void> _onSendRequest(
      SendRequestEvent event, Emitter<PeopleState> emit) async {
    emit(state.copyWith(clearMessages: true));
    final result = await _sendRequest(event.toUid);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (connection) => emit(state.copyWith(
        actionSuccessMessage: 'Connection request sent to ${connection.otherName}!',
        clearSearch: true,
      )),
    );
  }

  Future<void> _onAcceptRequest(
      AcceptRequestEvent event, Emitter<PeopleState> emit) async {
    emit(state.copyWith(clearMessages: true));
    final result = await _acceptRequest(event.id);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (chatRoomId) => emit(state.copyWith(
        actionSuccessMessage: 'Connection accepted!',
        acceptedChatRoomId: chatRoomId,
      )),
    );
  }

  Future<void> _onRejectRequest(
      RejectRequestEvent event, Emitter<PeopleState> emit) async {
    emit(state.copyWith(clearMessages: true));
    final result = await _rejectRequest(event.id);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(state.copyWith(actionSuccessMessage: 'Request declined')),
    );
  }

  @override
  Future<void> close() {
    _acceptedSub?.cancel();
    _pendingSub?.cancel();
    _sentSub?.cancel();
    return super.close();
  }
}
