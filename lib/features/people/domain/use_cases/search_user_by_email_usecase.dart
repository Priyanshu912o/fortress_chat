import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/contact_profile_entity.dart';
import '../repository/people_repository.dart';

@lazySingleton
class SearchUserByEmailUsecase {
  final PeopleRepository _repository;
  SearchUserByEmailUsecase(this._repository);

  Future<Either<ChatFailures, List<ContactProfileEntity>>> call(String email) {
    return _repository.searchUserByEmail(email);
  }
}
