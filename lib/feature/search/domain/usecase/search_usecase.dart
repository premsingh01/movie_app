import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/search/domain/repository.dart/search_repository.dart';
import 'package:oxidized/oxidized.dart';

class SearchUsecase {
  SearchRepository repository;
  SearchUsecase(this.repository);
  Future<Result<Movie,Err>> search(String query)=> repository.search(query);
}