import 'package:injectable/injectable.dart';
import '../entities/connection_entity.dart';
import '../repository/people_repository.dart';

@lazySingleton
class WatchPendingRequestsUsecase {
  final PeopleRepository _repository;
  WatchPendingRequestsUsecase(this._repository);

  Stream<List<ConnectionEntity>> call() {
    return _repository.watchPendingRequests();
  }
}
