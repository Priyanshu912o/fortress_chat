import 'package:injectable/injectable.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class SendTypingUsecase {
  final MessagingRepository _repository;
  SendTypingUsecase(this._repository);

  void call(String chatRoomId, bool isTyping) {
    _repository.sendTyping(chatRoomId, isTyping);
  }
}
