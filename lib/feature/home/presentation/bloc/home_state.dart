import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

sealed class HomeState {}


class HomeInitialState implements HomeState {}

class HomeLoadingState implements HomeState {}

class HomeLoadedState implements HomeState {
  List<MovieEntity> trending;
  List<MovieEntity> nowPlaying;
  HomeLoadedState({required this.trending, required this.nowPlaying});
}

class HomeFailureState implements HomeState {
  final String errorMsg;
  HomeFailureState({required this.errorMsg});
}