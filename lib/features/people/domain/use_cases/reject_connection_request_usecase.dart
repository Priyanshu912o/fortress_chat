import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../repository/people_repository.dart';

@lazySingleton
class RejectConnectionRequestUsecase {
  final PeopleRepository _repository;
  RejectConnectionRequestUsecase(this._repository);

  Future<Either<ChatFailures, Unit>> call(String id) {
    return _repository.rejectConnectionRequest(id);
  }
}
