import 'package:injectable/injectable.dart';
import '../entities/chat_room.dart';
import '../repository/conversations_repository.dart';

@lazySingleton
class WatchChatRoomsUsecase {
  final ConversationsRepository _repository;
  WatchChatRoomsUsecase(this._repository);

  Stream<List<ChatRoom>> call() {
    return _repository.watchChatRooms();
  }
}
