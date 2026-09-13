import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_room.dart';

class ConversationsState extends Equatable {
  final bool isLoading;
  final List<ChatRoom> chatRooms;
  final ChatRoom? createdChatRoom;
  final String? errorMessage;

  const ConversationsState({
    this.isLoading = false,
    this.chatRooms = const [],
    this.createdChatRoom,
    this.errorMessage,
  });

  ConversationsState copyWith({
    bool? isLoading,
    List<ChatRoom>? chatRooms,
    ChatRoom? createdChatRoom,
    String? errorMessage,
    bool clearCreated = false,
  }) {
    return ConversationsState(
      isLoading: isLoading ?? this.isLoading,
      chatRooms: chatRooms ?? this.chatRooms,
      createdChatRoom: clearCreated ? null : (createdChatRoom ?? this.createdChatRoom),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, chatRooms, createdChatRoom, errorMessage];
}
