import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/chat_room.dart';
import '../repository/conversations_repository.dart';

@lazySingleton
class CreateGroupChatUsecase {
  final ConversationsRepository _repository;
  CreateGroupChatUsecase(this._repository);

  Future<Either<ChatFailures, ChatRoom>> call(
    String name,
    List<String> participantUids,
  ) {
    return _repository.createGroupChat(name, participantUids);
  }
}
