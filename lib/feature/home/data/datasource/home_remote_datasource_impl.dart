import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/data/model/movie_detail_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<Movie>> getMovies();
  Future<List<Movie>> getTrendingMovies({int page = 1});
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<MovieDetailsModel> getMovieDetails({required int movieId});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiClient apiClient;

  const HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<List<Movie>> getMovies() async {
    final response = await apiClient.getMovies();
    return response.movieList as List<Movie>;
  }

  @override
  Future<List<Movie>> getTrendingMovies({int page = 1}) async {
    final response = await apiClient.getTrendingMovies(page);
    return response.movieList as List<Movie>;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await apiClient.getNowPlayingMovies(page);
    return response.movieList as List<Movie>;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int movieId}) async {
    final response = await apiClient.getMovieDetails(movieId);
    return response;
  }
}
