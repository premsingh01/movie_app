



import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';

class HomeRemoteDatasourceImpl implements HomeDatasource {
  final ApiClient apiClient;

  const HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<HomeModel> getMovies() async {
    final response = await apiClient.getMovies();
    return response;
  }
}