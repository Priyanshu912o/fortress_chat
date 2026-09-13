import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/create_group_chat_usecase.dart';
import '../../domain/use_cases/get_or_create_direct_chat_usecase.dart';
import '../../domain/use_cases/sync_chat_rooms_usecase.dart';
import '../../domain/use_cases/watch_chat_rooms_usecase.dart';
import 'conversations_event.dart';
import 'conversations_state.dart';

@injectable
class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final WatchChatRoomsUsecase _watchChatRooms;
  final GetOrCreateDirectChatUsecase _getOrCreateDirectChat;
  final CreateGroupChatUsecase _createGroupChat;
  final SyncChatRoomsUsecase _syncChatRooms;

  StreamSubscription? _roomsSub;

  ConversationsBloc(
    this._watchChatRooms,
    this._getOrCreateDirectChat,
    this._createGroupChat,
    this._syncChatRooms,
  ) : super(const ConversationsState()) {
    on<LoadChatRooms>(_onLoadChatRooms);
    on<RefreshChatRooms>(_onRefreshChatRooms);
    on<CreateDirectChatEvent>(_onCreateDirectChat);
    on<CreateGroupChatEvent>(_onCreateGroupChat);
    on<ChatRoomsUpdated>(_onRoomsUpdated);
  }

  void _onLoadChatRooms(LoadChatRooms event, Emitter<ConversationsState> emit) {
    emit(state.copyWith(isLoading: true));

    _roomsSub?.cancel();
    _roomsSub = _watchChatRooms().listen((rooms) {
      add(ChatRoomsUpdated(rooms));
    });

    _syncChatRooms().then((_) {});

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onRefreshChatRooms(
      RefreshChatRooms event, Emitter<ConversationsState> emit) async {
    final result = await _syncChatRooms();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => null,
    );
  }

  void _onRoomsUpdated(
      ChatRoomsUpdated event, Emitter<ConversationsState> emit) {
    emit(state.copyWith(chatRooms: event.rooms));
  }

  Future<void> _onCreateDirectChat(
      CreateDirectChatEvent event, Emitter<ConversationsState> emit) async {
    emit(state.copyWith(clearCreated: true));
    final result = await _getOrCreateDirectChat(event.otherUid);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (room) => emit(state.copyWith(createdChatRoom: room)),
    );
  }

  Future<void> _onCreateGroupChat(
      CreateGroupChatEvent event, Emitter<ConversationsState> emit) async {
    emit(state.copyWith(clearCreated: true));
    final result = await _createGroupChat(event.name, event.participantUids);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (room) => emit(state.copyWith(createdChatRoom: room)),
    );
  }

  @override
  Future<void> close() {
    _roomsSub?.cancel();
    return super.close();
  }
}
