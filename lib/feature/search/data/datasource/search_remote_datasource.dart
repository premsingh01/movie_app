import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/search/data/model/search_model.dart';

abstract class SearchRemoteDatasource {
  Future<SearchModel> searchMovies(String query);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final ApiClient apiClient;

  const SearchRemoteDatasourceImpl(this.apiClient);

  @override
  Future<SearchModel> searchMovies(String query) async {
    final response = await apiClient.searchMovies(query);
    return SearchModel(
      page: response.page,
      movieList: response.movieList,
    );
  }
}
