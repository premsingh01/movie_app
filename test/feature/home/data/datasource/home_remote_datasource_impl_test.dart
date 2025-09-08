



import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';

class MockApiClient extends Mock implements ApiClient {}
void main() {
  late HomeDatasource datasource;
  late ApiClient apiClient;

  setUp(() {
    apiClient = MockApiClient();
    datasource = HomeRemoteDatasourceImpl(apiClient);
  });

  test("Should get HomeModel when called remote datasource", () async {
    final expected = HomeModel(page: 1, results: []);
    when(() => apiClient.getMovies()).thenAnswer((_) async=> expected);
    final result = await datasource.getMovies();

    expect(expected, result);

  });

}