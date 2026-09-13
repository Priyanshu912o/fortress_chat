import 'package:fpdart/fpdart.dart';
import '../../../../core/components/chat_failures.dart';
import '../entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<Either<ChatFailures, SearchResultEntity>> searchAll(String query);
}
