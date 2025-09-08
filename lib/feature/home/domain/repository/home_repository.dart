

import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getMovies();
}