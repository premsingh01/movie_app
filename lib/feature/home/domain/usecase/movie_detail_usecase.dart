



import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:oxidized/oxidized.dart';

class MovieDetailUsecase {
  final HomeRepository homeRepository;  
  const MovieDetailUsecase(this.homeRepository);

  Future<Result<MovieDetailsEntity, Err>> call({required int movieId}) {
    return homeRepository.getMovieDetails(movieId: movieId);
  }
}