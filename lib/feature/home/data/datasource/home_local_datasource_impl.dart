import 'package:movie_app/feature/home/data/model/home_model.dart';

abstract class HomeLocalDatasource {
  
  Future<HomeModel> getMovies();
}


class HomeLocalDatasourceImpl implements HomeLocalDatasource {

  @override
  Future<HomeModel> getMovies() async {
    return HomeModel(page: 1, movieList: []);
  }
}