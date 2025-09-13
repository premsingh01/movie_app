


import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:oxidized/oxidized.dart';

class HomeUsecase {
  final HomeRepository homeRepository;

  const HomeUsecase(this.homeRepository);

  Future<Result<List<MovieEntity>, Err>> call() async {
    return homeRepository.getMovies();
    }
}