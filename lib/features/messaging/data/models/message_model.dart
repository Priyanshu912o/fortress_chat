import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/message_content.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messageId,
    required super.chatRoomId,
    required super.senderId,
    required super.content,
    required super.sentAt,
    super.deletedAt,
    super.clientMessageId,
    super.status = 'sent',
    super.isMe = false,
    super.senderName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, {String? currentUid}) {
    final senderId = json['senderId'] as String;
    final isMe = currentUid != null ? (senderId == currentUid) : false;
    final sender = json['sender'] as Map<String, dynamic>?;

    final receipts = json['receipts'] as List<dynamic>? ?? [];
    String status = 'sent';
    if (receipts.any((r) => r['readAt'] != null)) {
      status = 'read';
    } else if (receipts.any((r) => r['deliveredAt'] != null)) {
      status = 'delivered';
    }

    final messageId = json['id'] as String;
    final clientMessageId = json['clientMessageId'] as String? ?? messageId;

    return MessageModel(
      messageId: messageId,
      clientMessageId: clientMessageId,
      chatRoomId: json['chatRoomId'] as String,
      senderId: senderId,
      senderName: sender?['name'] as String?,
      content: MessageContent(
        messageId: messageId,
        body: json['body'] as String?,
        mediaUrl: null,
      ),
      sentAt: json['sentAt'] != null
          ? DateTime.parse(json['sentAt'] as String)
          : DateTime.now(),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
      status: status,
      isMe: isMe,
    );
  }

  factory MessageModel.fromDrift(CachedMessage row) {
    return MessageModel(
      messageId: row.serverMessageId ?? row.clientMessageId,
      clientMessageId: row.clientMessageId,
      chatRoomId: row.chatRoomId,
      senderId: row.senderId,
      senderName: row.senderName,
      content: MessageContent(
        messageId: row.serverMessageId ?? row.clientMessageId,
        body: row.body,
        mediaUrl: null,
      ),
      sentAt: row.sentAt,
      status: row.status,
      isMe: row.isMe,
    );
  }

  CachedMessagesCompanion toDrift() {
    return CachedMessagesCompanion(
      id: Value(clientMessageId ?? messageId),
      clientMessageId: Value(clientMessageId ?? messageId),
      serverMessageId: Value(messageId),
      chatRoomId: Value(chatRoomId),
      senderId: Value(senderId),
      senderName: Value(senderName),
      body: Value(body),
      sentAt: Value(sentAt),
      status: Value(status),
      isMe: Value(isMe),
    );
  }
}
