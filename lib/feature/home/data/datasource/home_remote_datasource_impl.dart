import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';

abstract class HomeRemoteDatasource {
  
  Future<HomeModel> getMovies();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiClient apiClient;

  const HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<HomeModel> getMovies() async {
    final response = await apiClient.getMovies();
    return response;
  }
}