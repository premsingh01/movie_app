import 'package:movie_app/core/database/dao/movie_dao.dart';
import 'package:movie_app/feature/home/data/datasource/home_local_datasource_impl.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:oxidized/oxidized.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;
  final HomeLocalDatasource localDatasource;

  const HomeRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Result<HomeEntity, Err>> getMovies() async {
    // First try remote
    final remoteResult = await _fetchRemoteMovies();

    // +++++++++++++++
    await remoteResult.when(
      ok: (p0) async => await localDatasource.saveMovies(p0.movieList).then((val) async {
        final localResponse = await localDatasource.getMovies();
    print("local reponse in home Repository ${localResponse.movieList.length}");
      }),
       err: (err) => "");
    // final localResponse = await localDatasource.getMovies();
    // print("local reponse in home Repository ${localResponse.toString()}");
    // +++++++++++++++

    if (remoteResult.isOk()) {
      return remoteResult;
    }

    // If remote fails, fallback to local
    final localResult = await _fetchLocalMovies();
    return localResult;
  }

  Future<Result<HomeEntity, Err>> _fetchRemoteMovies() async {
    return await Result.asyncOf(() => remoteDatasource.getMovies());
  }

  Future<Result<HomeEntity, Err>> _fetchLocalMovies() async {
    return await Result.asyncOf(() => localDatasource.getMovies());
  }

  @override
  Future<Result<MovieDetailsEntity, Err>> getMovieDetails({
    required int movieId,
  }) async {
    final remoteResult = await Result.asyncOf<MovieDetailsEntity, Err>(
      () => remoteDatasource.getMovieDetails(movieId: movieId),
    );
    return remoteResult;
  }
}
