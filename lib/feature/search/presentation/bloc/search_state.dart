import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

sealed class SearchState {}

class SearchInitialState implements SearchState {}

class SearchLoadingState implements SearchState {}

class SearchLoadedState implements SearchState {
  final List<MovieEntity> movieList;
  final String query;
  
  SearchLoadedState({required this.movieList, required this.query});
}

class SearchFailureState implements SearchState {
  final String errorMsg;
  
  SearchFailureState({required this.errorMsg});
}

class SearchEmptyState implements SearchState {
  final String query;
  
  SearchEmptyState({required this.query});
}
