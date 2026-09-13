import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_room.dart';

sealed class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatRooms extends ConversationsEvent {
  const LoadChatRooms();
}

class RefreshChatRooms extends ConversationsEvent {
  const RefreshChatRooms();
}

class CreateDirectChatEvent extends ConversationsEvent {
  final String otherUid;
  const CreateDirectChatEvent(this.otherUid);

  @override
  List<Object?> get props => [otherUid];
}

class CreateGroupChatEvent extends ConversationsEvent {
  final String name;
  final List<String> participantUids;
  const CreateGroupChatEvent({required this.name, required this.participantUids});

  @override
  List<Object?> get props => [name, participantUids];
}

class ChatRoomsUpdated extends ConversationsEvent {
  final List<ChatRoom> rooms;
  const ChatRoomsUpdated(this.rooms);

  @override
  List<Object?> get props => [rooms];
}
