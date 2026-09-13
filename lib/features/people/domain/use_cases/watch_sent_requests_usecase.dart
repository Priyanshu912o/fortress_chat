import 'package:injectable/injectable.dart';
import '../entities/connection_entity.dart';
import '../repository/people_repository.dart';

@lazySingleton
class WatchSentRequestsUsecase {
  final PeopleRepository _repository;
  WatchSentRequestsUsecase(this._repository);

  Stream<List<ConnectionEntity>> call() {
    return _repository.watchSentRequests();
  }
}
