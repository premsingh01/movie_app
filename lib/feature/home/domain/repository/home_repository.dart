

import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';
import 'package:oxidized/oxidized.dart';

abstract class HomeRepository {
  Future<Result<List<MovieEntity>,Err>> getMovies();
  Future<Result<List<MovieEntity>,Err>> getTrendingMovies({int page = 1});
  Future<Result<List<MovieEntity>,Err>> getNowPlayingMovies({int page = 1});
  Future<Result<MovieDetailsEntity , Err>> getMovieDetails({required int movieId});
}