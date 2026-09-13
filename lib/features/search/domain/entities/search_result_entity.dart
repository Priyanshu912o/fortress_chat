import 'package:equatable/equatable.dart';
import '../../../conversations/domain/entities/chat_room.dart';
import '../../../messaging/domain/entities/message_entity.dart';
import '../../../people/domain/entities/connection_entity.dart';

class SearchResultEntity extends Equatable {
  final List<ChatRoom> rooms;
  final List<MessageEntity> messages;
  final List<ConnectionEntity> contacts;

  const SearchResultEntity({
    this.rooms = const [],
    this.messages = const [],
    this.contacts = const [],
  });

  @override
  List<Object?> get props => [rooms, messages, contacts];
}
