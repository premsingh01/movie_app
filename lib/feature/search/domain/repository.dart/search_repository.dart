import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:oxidized/oxidized.dart';

abstract class SearchRepository {
  Future<Result<Movie,Err>> search(String query);
}