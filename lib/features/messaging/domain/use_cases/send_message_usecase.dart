import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class SendMessageUsecase {
  final MessagingRepository _repository;
  SendMessageUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call(String chatRoomId, String body) {
    return _repository.sendMessage(chatRoomId, body);
  }
}
