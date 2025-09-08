


import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';

class HomeUsecase {
  final HomeRepository homeRepository;

  const HomeUsecase(this.homeRepository);

  Future<HomeEntity> call() async {
    return homeRepository.getMovies();
    }
}