import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class GlobalSearchUsecase {
  final SearchRepository _repository;
  const GlobalSearchUsecase(this._repository);

  Future<Either<ChatFailures, SearchResultEntity>> call(String query) {
    return _repository.searchAll(query);
  }
}
