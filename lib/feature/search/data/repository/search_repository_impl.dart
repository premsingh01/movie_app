import 'package:flutter/foundation.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/search/data/datasource/search_remote_datasource.dart';
import 'package:movie_app/feature/search/domain/repository/search_repository.dart';
import 'package:oxidized/oxidized.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource remoteDatasource;

  const SearchRepositoryImpl(this.remoteDatasource);

  @override
  Future<Result<HomeEntity, String>> searchMovies(String query) async {
    try {
      final result = await remoteDatasource.searchMovies(query);
      return Ok(result);
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
      return Err(e.toString());
    }
  }
}
