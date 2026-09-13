import 'package:equatable/equatable.dart';
import '../../domain/entities/message_entity.dart';

sealed class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object?> get props => [];
}

class LoadMessages extends MessagingEvent {
  final String chatRoomId;
  const LoadMessages(this.chatRoomId);

  @override
  List<Object?> get props => [chatRoomId];
}

class SendMessageEvent extends MessagingEvent {
  final String body;
  const SendMessageEvent(this.body);

  @override
  List<Object?> get props => [body];
}

class LoadMoreMessages extends MessagingEvent {
  const LoadMoreMessages();
}

class SendTypingEvent extends MessagingEvent {
  final bool isTyping;
  const SendTypingEvent(this.isTyping);

  @override
  List<Object?> get props => [isTyping];
}

class MessagesUpdated extends MessagingEvent {
  final List<MessageEntity> messages;
  const MessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

class RealtimeEventReceived extends MessagingEvent {
  final Map<String, dynamic> event;
  const RealtimeEventReceived(this.event);

  @override
  List<Object?> get props => [event];
}
