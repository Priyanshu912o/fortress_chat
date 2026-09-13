import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/chat_failures.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_local_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource _localDataSource;
  SearchRepositoryImpl(this._localDataSource);

  @override
  Future<Either<ChatFailures, SearchResultEntity>> searchAll(String query) async {
    try {
      final result = await _localDataSource.searchAll(query);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
