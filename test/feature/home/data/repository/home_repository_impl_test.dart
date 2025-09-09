import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/feature/home/data/datasource/home_datasource.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';

class MockRemoteDatasource extends Mock implements HomeDatasource {}

class MockLocalDatasource extends Mock implements HomeDatasource {}


void main() {
  late HomeRepository repository;
  late MockRemoteDatasource remoteDatasource;
  late MockLocalDatasource localDatasource;

  setUp(() {
    remoteDatasource =
        MockRemoteDatasource(); // HomeRemoteDatasourceImpl(apiClient);
    localDatasource = MockLocalDatasource(); //HomeLocalDatasourceImpl();
    repository = HomeRepositoryImpl(remoteDatasource, localDatasource);
  });

  test("Should return Home entity when call getMovies", () async {    
    final expected = HomeModel(page: 1, movieList: []);
    when(
      () => remoteDatasource.getMovies(),
    ).thenAnswer((_) async => expected);
    
    final result = await repository.getMovies();
    expect(result,isA<HomeEntity>());
    expect(result, expected);
  });

  test("Should return get call from local if remote fails", () async {
    final expected = HomeModel(page: 1, movieList: []);
    when(
      () => remoteDatasource.getMovies(),
    ).thenThrow((_) async => SocketException('no internet'));

    when(() => localDatasource.getMovies(),).thenAnswer((_) async=> expected);
    
    final result = await repository.getMovies();
    expect(result,isA<HomeEntity>());
    expect(result, equals(expected));
    verify(()=>localDatasource.getMovies()).called(1);
    verify(()=>remoteDatasource.getMovies()).called(1);    
  });
}
