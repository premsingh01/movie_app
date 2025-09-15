import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/search/domain/repository/search_repository.dart';
import 'package:oxidized/oxidized.dart';

class SearchUsecase {
  final SearchRepository repository;
  
  SearchUsecase(this.repository);
  
  Future<Result<HomeEntity, String>> searchMovies(String query) => 
      repository.searchMovies(query);
}