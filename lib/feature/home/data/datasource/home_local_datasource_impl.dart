import 'package:movie_app/core/database/dao/movie_dao.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

abstract class HomeLocalDatasource {
  Future<HomeModel> getMovies();
  Future<void> saveMovies(List<MovieEntity> apiMovieList);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final movieDao = MovieDao();

  @override
  Future<HomeModel> getMovies() async {
    final List<Map<String, dynamic>> movies = await movieDao.getMovies();
    final List<MovieEntity> movieResult = movies
        .map((e) => Movie.fromJson(e))
        .toList(); //.forEach((val) => Movie.fromJson(val)).toList();
    print("+++++++++++++Local Storage movies result: ${movieResult.length}");

    return HomeModel(page: 0, movieList: movieResult); //correct (doubt)
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
    }).toList(); //convertApiToDb(apiMovies);
    await movieDao.insertMovies(movies);

    //       final db = AppDatabase();

    // // Converting JSON to Drift companion
    // final movies = apiMovie.map((json) {
    //   return MoviesCompanion.insert(
    //     id: Value(json.id),
    //     adult: Value(json.adult),
    //     backdropPath: Value(json.backdropPath),
    //     originalLanguage: Value(json.originalLanguage),
    //     originalTitle: Value(json.originalTitle),
    //     overview: Value(json.overview),
    //     popularity: Value((json.popularity ?? 0).toDouble()),
    //     posterPath: Value(json.posterPath),
    //     releaseDate: json.releaseDate != null
    //         ? Value(json.releaseDate)
    //         : const Value.absent(),
    //     title: Value(json.title),
    //     video: Value(json.video),
    //     voteAverage: Value((json.voteAverage ?? 0).toDouble()),
    //     voteCount: Value(json.voteCount),
    //   );
    // }).toList();
    // await db.movieDao.insertMovies(movies);
  }
}
