import 'package:equatable/equatable.dart';

class MessageContent extends Equatable {
  final String messageId;
  final String? body;
  final String? mediaUrl;

  const MessageContent({
    required this.messageId,
    required this.body,
    required this.mediaUrl,
  });

  @override
  List<Object?> get props => [messageId, body, mediaUrl];
}
