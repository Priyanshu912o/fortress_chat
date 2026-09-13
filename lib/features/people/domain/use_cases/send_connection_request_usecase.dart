import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/connection_entity.dart';
import '../repository/people_repository.dart';

@lazySingleton
class SendConnectionRequestUsecase {
  final PeopleRepository _repository;
  SendConnectionRequestUsecase(this._repository);

  Future<Either<ChatFailures, ConnectionEntity>> call(String toUid) {
    return _repository.sendConnectionRequest(toUid);
  }
}
