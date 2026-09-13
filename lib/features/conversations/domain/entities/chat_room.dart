import 'package:equatable/equatable.dart';

class ChatRoom extends Equatable {
  final String chatRoomId;
  final bool isDirect;
  final DateTime createdAt;
  final List<String> participantUids;

  final String? groupName;
  final String? groupDpUrl;
  final List<String> adminIds;

  final String? lastMessageBody;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final int unreadCount;
  final String? otherUserName;
  final String? otherUserDpUrl;

  const ChatRoom({
    required this.createdAt,
    required this.chatRoomId,
    required this.isDirect,
    required this.participantUids,
    this.groupName,
    this.groupDpUrl,
    this.adminIds = const [],
    this.lastMessageBody,
    this.lastMessageAt,
    this.lastSenderId,
    this.unreadCount = 0,
    this.otherUserName,
    this.otherUserDpUrl,
  });

  String get id => chatRoomId;

  String get displayName {
    if (isDirect) {
      return otherUserName ?? 'Chat';
    }
    return groupName ?? 'Group Chat';
  }

  @override
  List<Object?> get props => [
        createdAt,
        chatRoomId,
        isDirect,
        participantUids,
        groupDpUrl,
        groupName,
        adminIds,
        lastMessageBody,
        lastMessageAt,
        lastSenderId,
        unreadCount,
        otherUserName,
        otherUserDpUrl,
      ];
}
