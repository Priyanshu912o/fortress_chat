import '../../domain/entities/search_result_entity.dart';

abstract class SearchLocalDataSource {
  Future<SearchResultEntity> searchAll(String query);
}
