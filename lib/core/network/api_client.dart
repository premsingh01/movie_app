import 'package:dio/dio.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/data/model/movie_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/discover/movie")
  Future<HomeModel> getMovies();

  @GET("/trending/movie/day")
  Future<HomeModel> getTrendingMovies(
    @Query("page") int page,
  );

  @GET("/movie/now_playing")
  Future<HomeModel> getNowPlayingMovies(
    @Query("page") int page,
  );

  @GET("/movie/{id}")
  Future<MovieDetailsModel> getMovieDetails(@Path("id") int movieId);

  @GET("/search/movie")
  Future<HomeModel> searchMovies(
    @Query("query") String query,
  );
}
