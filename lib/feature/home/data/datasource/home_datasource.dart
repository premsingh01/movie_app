import 'package:movie_app/feature/home/data/model/home_model.dart';



abstract class HomeDatasource {
  
  Future<HomeModel> getMovies();
}