import 'package:movie_app/core/database/dao/movie_dao.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/core/database/dao/now_playing_dao.dart';
import 'package:movie_app/core/database/dao/trending_dao.dart';

abstract class HomeLocalDatasource {
  Future<List<Movie>> getMovies();
  Future<void> saveMovies(List<MovieEntity> apiMovieList);
  Future<List<Movie>> getNowPlaying();
  Future<void> saveNowPlaying(List<MovieEntity> apiMovieList);
  Future<List<Movie>> getTrending();
  Future<void> saveTrending(List<MovieEntity> apiMovieList);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final movieDao = MovieDao();
  final nowPlayingDao = NowPlayingDao();
  final trendingDao = TrendingDao();

  @override
  Future<List<Movie>> getMovies() async {
    final List<Map<String, dynamic>> movies = await movieDao.getMovies();
    final List<Movie> movieResult = movies
        .map((e) => Movie.fromJson(e))
        .toList();
    print("+++++++++++++Local Storage getMovies result: ${movieResult.length}");

    return movieResult;
  }

  @override
  Future<void> saveMovies(List<MovieEntity> apiMovieList) async {
    final movieDao = MovieDao();

    final List<Map<String, dynamic>> movies = apiMovieList.map((json) {
      return {
        "id": json.id,
        "backdrop_path": json.backdropPath,
        "original_language": json.originalLanguage,
        "original_title": json.originalTitle,
        "overview": json.overview,
        "popularity": json.popularity,
        "poster_path": json.posterPath,
        "release_date": json.releaseDate.toString(),
        "title": json.title,
        "vote_average": json.voteAverage,
        "vote_count": json.voteCount,
      };
    }).toList();
    await movieDao.insertMovies(movies);
  }

  List<Map<String, dynamic>> _serialize(List<MovieEntity> apiMovieList) {
    return apiMovieList.map((json) {
      return {
        "id": json.id,
        "backdrop_path": json.backdropPath,
        "original_language": json.originalLanguage,
        "original_title": json.originalTitle,
        "overview": json.overview,
        "popularity": json.popularity,
        "poster_path": json.posterPath,
        "release_date": json.releaseDate?.toIso8601String(),
        "title": json.title,
        "vote_average": json.voteAverage,
        "vote_count": json.voteCount,
      };
    }).toList();
  }

  @override
  Future<void> saveNowPlaying(List<MovieEntity> apiMovieList) async {
    final rows = _serialize(apiMovieList);
    await nowPlayingDao.replaceAll(rows);
  }

  @override
  Future<List<Movie>> getNowPlaying() async {
    final rows = await nowPlayingDao.getAll();
    return rows.map((e) => Movie.fromJson(e)).toList();
  }

  @override
  Future<void> saveTrending(List<MovieEntity> apiMovieList) async {
    final rows = _serialize(apiMovieList);
    await trendingDao.replaceAll(rows);
  }

  @override
  Future<List<Movie>> getTrending() async {
    final rows = await trendingDao.getAll();
    return rows.map((e) => Movie.fromJson(e)).toList();
  }
}
