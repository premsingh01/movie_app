


import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';

class HomeLocalDatasourceImpl implements HomeDatasource {

  @override
  Future<HomeModel> getMovies() async {
    return HomeModel(page: 1, movieList: []);
  }
}