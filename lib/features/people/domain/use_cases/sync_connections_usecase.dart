import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/people_repository.dart';

@lazySingleton
class SyncConnectionsUsecase {
  final PeopleRepository _repository;
  SyncConnectionsUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call() {
    return _repository.syncConnections();
  }
}
