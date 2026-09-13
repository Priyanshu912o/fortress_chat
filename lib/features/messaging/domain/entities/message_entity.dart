import 'package:equatable/equatable.dart';
import 'message_content.dart';

class MessageEntity extends Equatable {
  final String messageId;
  final String chatRoomId;
  final String senderId;
  final MessageContent content;
  final DateTime sentAt;
  final DateTime? deletedAt;
  final String? clientMessageId;
  final String status; // 'pending', 'sending', 'sent', 'delivered', 'read', 'failed'
  final bool isMe;
  final String? senderName;

  const MessageEntity({
    required this.messageId,
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    required this.sentAt,
    this.deletedAt,
    this.clientMessageId,
    this.status = 'sent',
    this.isMe = false,
    this.senderName,
  });

  String get body => content.body ?? '';

  @override
  List<Object?> get props => [
        messageId,
        chatRoomId,
        senderId,
        content,
        sentAt,
        deletedAt,
        clientMessageId,
        status,
        isMe,
        senderName,
      ];
}
