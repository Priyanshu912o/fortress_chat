import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/message_entity.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class LoadOlderMessagesUsecase {
  final MessagingRepository _repository;
  LoadOlderMessagesUsecase(this._repository);

  Future<Either<ChatFailures, List<MessageEntity>>> call(
    String chatRoomId, {
    required DateTime beforeTimestamp,
    int limit = 30,
  }) {
    return _repository.loadOlderMessages(
      chatRoomId,
      beforeTimestamp: beforeTimestamp,
      limit: limit,
    );
  }
}
