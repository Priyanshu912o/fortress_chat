import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/people_repository.dart';

@lazySingleton
class AcceptConnectionRequestUsecase {
  final PeopleRepository _repository;
  AcceptConnectionRequestUsecase(this._repository);

  Future<Either<ChatFailures, String>> call(String id) {
    return _repository.acceptConnectionRequest(id);
  }
}
