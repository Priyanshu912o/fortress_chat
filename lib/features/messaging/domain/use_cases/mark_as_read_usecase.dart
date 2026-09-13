import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class MarkAsReadUsecase {
  final MessagingRepository _repository;
  MarkAsReadUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call(String chatRoomId) {
    return _repository.markAsRead(chatRoomId);
  }
}
