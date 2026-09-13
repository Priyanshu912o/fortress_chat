import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/load_older_messages_usecase.dart';
import '../../domain/use_cases/mark_as_read_usecase.dart';
import '../../domain/use_cases/send_message_usecase.dart';
import '../../domain/use_cases/send_typing_usecase.dart';
import '../../domain/use_cases/watch_messages_usecase.dart';
import '../../domain/use_cases/watch_realtime_events_usecase.dart';
import 'messaging_event.dart';
import 'messaging_state.dart';

@injectable
class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final WatchMessagesUsecase _watchMessages;
  final SendMessageUsecase _sendMessage;
  final LoadOlderMessagesUsecase _loadOlderMessages;
  final MarkAsReadUsecase _markAsRead;
  final SendTypingUsecase _sendTyping;
  final WatchRealtimeEventsUsecase _watchRealtimeEvents;

  StreamSubscription? _messagesSub;
  StreamSubscription? _wsEventsSub;
  Timer? _typingTimer;

  MessagingBloc(
    this._watchMessages,
    this._sendMessage,
    this._loadOlderMessages,
    this._markAsRead,
    this._sendTyping,
    this._watchRealtimeEvents,
  ) : super(const MessagingState()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<LoadMoreMessages>(_onLoadMoreMessages);
    on<SendTypingEvent>(_onSendTyping);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<RealtimeEventReceived>(_onRealtimeEventReceived);
  }

  void _onLoadMessages(LoadMessages event, Emitter<MessagingState> emit) {
    emit(state.copyWith(chatRoomId: event.chatRoomId, isLoading: true));

    _messagesSub?.cancel();
    _messagesSub = _watchMessages(event.chatRoomId).listen((messages) {
      add(MessagesUpdated(messages));
    });

    _wsEventsSub?.cancel();
    _wsEventsSub = _watchRealtimeEvents().listen((eventData) {
      add(RealtimeEventReceived(eventData));
    });

    _markAsRead(event.chatRoomId).then((_) {});

    emit(state.copyWith(isLoading: false));
  }

  void _onMessagesUpdated(
      MessagesUpdated event, Emitter<MessagingState> emit) {
    emit(state.copyWith(messages: event.messages));
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<MessagingState> emit) async {
    if (event.body.trim().isEmpty || state.chatRoomId.isEmpty) return;
    _sendTyping(state.chatRoomId, false);
    await _sendMessage(state.chatRoomId, event.body.trim());
  }

  Future<void> _onLoadMoreMessages(
      LoadMoreMessages event, Emitter<MessagingState> emit) async {
    if (state.isLoadingMore || !state.hasMore || state.messages.isEmpty) return;
    emit(state.copyWith(isLoadingMore: true));

    final oldestTimestamp = state.messages.last.sentAt;
    final result = await _loadOlderMessages(
      state.chatRoomId,
      beforeTimestamp: oldestTimestamp,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: failure.message,
      )),
      (older) {
        final hasMore = older.isNotEmpty;
        emit(state.copyWith(
          isLoadingMore: false,
          hasMore: hasMore,
        ));
      },
    );
  }

  void _onSendTyping(SendTypingEvent event, Emitter<MessagingState> emit) {
    if (state.chatRoomId.isNotEmpty) {
      _sendTyping(state.chatRoomId, event.isTyping);
    }
  }

  void _onRealtimeEventReceived(
      RealtimeEventReceived event, Emitter<MessagingState> emit) {
    final type = event.event['type'] as String?;
    final data = event.event['data'] as Map<String, dynamic>?;

    if (type == 'typing' && data != null) {
      final roomId = data['chatRoomId'] as String?;
      if (roomId == state.chatRoomId) {
        final isTyping = data['isTyping'] as bool? ?? false;
        emit(state.copyWith(isOtherTyping: isTyping));

        if (isTyping) {
          _typingTimer?.cancel();
          _typingTimer = Timer(const Duration(seconds: 4), () {
            if (!isClosed) {
              add(const RealtimeEventReceived({
                'type': 'typing',
                'data': {'chatRoomId': '', 'isTyping': false}
              }));
            }
          });
        }
      }
    }
  }

  @override
  Future<void> close() {
    _messagesSub?.cancel();
    _wsEventsSub?.cancel();
    _typingTimer?.cancel();
    return super.close();
  }
}
