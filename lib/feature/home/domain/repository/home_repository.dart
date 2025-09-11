

import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:oxidized/oxidized.dart';

abstract class HomeRepository {
  Future<Result<HomeEntity,Err>> getMovies();
}