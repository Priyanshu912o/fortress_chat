import 'package:equatable/equatable.dart';
import '../../domain/entities/connection_entity.dart';
import '../../domain/entities/contact_profile_entity.dart';

class PeopleState extends Equatable {
  final bool isLoading;
  final bool isSearching;
  final List<ConnectionEntity> accepted;
  final List<ConnectionEntity> pendingIncoming;
  final List<ConnectionEntity> sentOutgoing;
  final List<ContactProfileEntity> searchResults;
  final String? errorMessage;
  final String? actionSuccessMessage;
  final String? acceptedChatRoomId;

  const PeopleState({
    this.isLoading = false,
    this.isSearching = false,
    this.accepted = const [],
    this.pendingIncoming = const [],
    this.sentOutgoing = const [],
    this.searchResults = const [],
    this.errorMessage,
    this.actionSuccessMessage,
    this.acceptedChatRoomId,
  });

  PeopleState copyWith({
    bool? isLoading,
    bool? isSearching,
    List<ConnectionEntity>? accepted,
    List<ConnectionEntity>? pendingIncoming,
    List<ConnectionEntity>? sentOutgoing,
    List<ContactProfileEntity>? searchResults,
    String? errorMessage,
    String? actionSuccessMessage,
    String? acceptedChatRoomId,
    bool clearSearch = false,
    bool clearMessages = false,
  }) {
    return PeopleState(
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      accepted: accepted ?? this.accepted,
      pendingIncoming: pendingIncoming ?? this.pendingIncoming,
      sentOutgoing: sentOutgoing ?? this.sentOutgoing,
      searchResults: clearSearch ? const [] : (searchResults ?? this.searchResults),
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
      actionSuccessMessage:
          clearMessages ? null : (actionSuccessMessage ?? this.actionSuccessMessage),
      acceptedChatRoomId:
          clearMessages ? null : (acceptedChatRoomId ?? this.acceptedChatRoomId),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSearching,
        accepted,
        pendingIncoming,
        sentOutgoing,
        searchResults,
        errorMessage,
        actionSuccessMessage,
        acceptedChatRoomId,
      ];
}
