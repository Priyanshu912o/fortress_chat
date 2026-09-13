import 'package:injectable/injectable.dart';
import '../entities/connection_entity.dart';
import '../repository/people_repository.dart';

@lazySingleton
class WatchAcceptedConnectionsUsecase {
  final PeopleRepository _repository;
  WatchAcceptedConnectionsUsecase(this._repository);

  Stream<List<ConnectionEntity>> call() {
    return _repository.watchAcceptedConnections();
  }
}
