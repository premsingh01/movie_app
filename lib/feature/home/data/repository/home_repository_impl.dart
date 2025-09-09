



import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource remoteDatasource;
  final HomeDatasource localDatasource;

  const HomeRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<HomeEntity> getMovies() async {
    try {
      return remoteDatasource.getMovies();
    } catch (e) {
      return localDatasource.getMovies();
    }
  }

}