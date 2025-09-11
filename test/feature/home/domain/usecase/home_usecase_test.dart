


import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:movie_app/feature/home/domain/usecase/home_usecase.dart';

class MockRepository extends Mock implements HomeRepository {}
void main() {
  late MockRepository repository;
  late HomeUsecase usecase;

  setUp(() {
    repository = MockRepository();
    usecase = HomeUsecase(repository);
  });

  test("Should get entity when usecase called", () async {
    final expected = HomeEntity(page: 2, movieList: []);
    // when(() => repository.getMovies()).thenAnswer((_) async => expected);
    final result = await usecase();
    expect(result, expected); 
  });
}