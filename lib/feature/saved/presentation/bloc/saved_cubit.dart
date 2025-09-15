import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/database/dao/movie_dao.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final MovieDao movieDao;
  SavedCubit(this.movieDao) : super(SavedInitialState());

  Future<void> loadSaved() async {
    emit(SavedLoadingState());
    try {
      final rows = await movieDao.getMovies();
      final movies = rows.map((e) => Movie.fromJson(e)).toList();
      if (movies.isEmpty) {
        emit(SavedEmptyState());
      } else {
        emit(SavedLoadedState(movieList: movies));
      }
    } catch (e) {
      emit(SavedFailureState(errorMsg: e.toString()));
    }
  }

  Future<void> removeById(int id) async {
    await movieDao.deleteMovie(id);
    await loadSaved();
  }

  Future<bool> isSaved(int id) async {
    return await movieDao.isSaved(id);
  }

  Future<void> toggleBookmarkFromEntity(dynamic movie) async {
    // Expects an object with MovieEntity-like fields
    final int? id = movie.id;
    if (id == null) return;

    final bool exists = await movieDao.isSaved(id);
    if (exists) {
      await movieDao.deleteMovie(id);
    } else {
      final map = {
        "id": movie.id,
        "backdrop_path": movie.backdropPath,
        "original_language": movie.originalLanguage,
        "original_title": movie.originalTitle,
        "overview": movie.overview,
        "popularity": movie.popularity,
        "poster_path": movie.posterPath,
        "release_date": movie.releaseDate?.toIso8601String(),
        "title": movie.title ?? movie.originalTitle,
        "vote_average": movie.voteAverage,
        "vote_count": movie.voteCount,
      };
      await movieDao.insertMovie(map);
    }
    await loadSaved();
  }
}
