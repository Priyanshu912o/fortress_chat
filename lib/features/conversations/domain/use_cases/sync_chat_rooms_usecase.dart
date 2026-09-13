import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/conversations_repository.dart';

@lazySingleton
class SyncChatRoomsUsecase {
  final ConversationsRepository _repository;
  SyncChatRoomsUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call() {
    return _repository.syncChatRooms();
  }
}
