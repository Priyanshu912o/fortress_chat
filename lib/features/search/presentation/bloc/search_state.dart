import 'package:Fortress/features/conversations/domain/entities/chat_room.dart';
import 'package:Fortress/features/messaging/domain/entities/message_entity.dart';
import 'package:Fortress/features/people/domain/entities/connection_entity.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final String query;
  final bool isLoading;
  final List<ChatRoom> rooms;
  final List<MessageEntity> messages;
  final List<ConnectionEntity> contacts;

  const SearchState({
    this.query = '',
    this.isLoading = false,
    this.rooms = const [],
    this.messages = const [],
    this.contacts = const [],
  });

  bool get isEmpty =>
      query.isNotEmpty &&
      !isLoading &&
      rooms.isEmpty &&
      messages.isEmpty &&
      contacts.isEmpty;

  bool get hasResults =>
      rooms.isNotEmpty || messages.isNotEmpty || contacts.isNotEmpty;

  SearchState copyWith({
    String? query,
    bool? isLoading,
    List<ChatRoom>? rooms,
    List<MessageEntity>? messages,
    List<ConnectionEntity>? contacts,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      rooms: rooms ?? this.rooms,
      messages: messages ?? this.messages,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [query, isLoading, rooms, messages, contacts];
}
