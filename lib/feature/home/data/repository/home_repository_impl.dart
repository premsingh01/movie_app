import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:oxidized/oxidized.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource remoteDatasource;
  final HomeDatasource localDatasource;

  const HomeRepositoryImpl(this.remoteDatasource, this.localDatasource);
@override
Future<Result<HomeEntity, Err>> getMovies() async {
  // First try remote
  final remoteResult = await _fetchRemoteMovies();

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
}
