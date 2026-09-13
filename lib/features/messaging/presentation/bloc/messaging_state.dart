import 'package:equatable/equatable.dart';
import '../../domain/entities/message_entity.dart';

class MessagingState extends Equatable {
  final String chatRoomId;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final List<MessageEntity> messages;
  final bool isOtherTyping;
  final String? errorMessage;

  const MessagingState({
    this.chatRoomId = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.messages = const [],
    this.isOtherTyping = false,
    this.errorMessage,
  });

  MessagingState copyWith({
    String? chatRoomId,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    List<MessageEntity>? messages,
    bool? isOtherTyping,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MessagingState(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      messages: messages ?? this.messages,
      isOtherTyping: isOtherTyping ?? this.isOtherTyping,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        chatRoomId,
        isLoading,
        isLoadingMore,
        hasMore,
        messages,
        isOtherTyping,
        errorMessage,
      ];
}
