import 'package:equatable/equatable.dart';

class MessageReciept extends Equatable {
  final String recieptId;
  final String messageId;
  final String chatRoomId;
  final String uid;
  final DateTime? readAt;
  final DateTime? deliveredAt;

  const MessageReciept({
    required this.recieptId,
    required this.messageId,
    required this.chatRoomId,
    required this.uid,
    required this.readAt,
    required this.deliveredAt,
  });

  @override
  List<Object?> get props => [
    recieptId,
    messageId,
    chatRoomId,
    uid,
    readAt,
    deliveredAt,
  ];
}
