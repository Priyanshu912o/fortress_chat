import 'package:injectable/injectable.dart';
import '../entities/message_entity.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class WatchMessagesUsecase {
  final MessagingRepository _repository;
  WatchMessagesUsecase(this._repository);

  Stream<List<MessageEntity>> call(String chatRoomId, {int limit = 30}) {
    return _repository.watchMessages(chatRoomId, limit: limit);
  }
}
