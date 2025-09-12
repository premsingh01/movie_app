import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/data/model/movie_detail_model.dart';

abstract class HomeRemoteDatasource {
  Future<HomeModel> getMovies();
  Future<MovieDetailsModel> getMovieDetails({required int movieId});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiClient apiClient;

  const HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<HomeModel> getMovies() async {
    final response = await apiClient.getMovies();
    return response;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int movieId}) async {
    final response = await apiClient.getMovieDetails(movieId);
    return response;
  }
}
