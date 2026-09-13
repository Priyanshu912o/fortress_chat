import 'package:injectable/injectable.dart';
import '../repository/messaging_repository.dart';

@lazySingleton
class WatchRealtimeEventsUsecase {
  final MessagingRepository _repository;
  WatchRealtimeEventsUsecase(this._repository);

  Stream<Map<String, dynamic>> call() {
    return _repository.watchRealtimeEvents();
  }
}
