import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/chat_room.dart';
import '../repository/conversations_repository.dart';

@lazySingleton
class GetOrCreateDirectChatUsecase {
  final ConversationsRepository _repository;
  GetOrCreateDirectChatUsecase(this._repository);

  Future<Either<ChatFailures, ChatRoom>> call(String otherUid) {
    return _repository.getOrCreateDirectChat(otherUid);
  }
}
