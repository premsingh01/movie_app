

import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';

sealed class MovieDetailsState {}

class MovieDetailsInitialState implements MovieDetailsState {}

class MovieDetailsLoadingState implements MovieDetailsState {}

class MovieDetailsLoadedState implements MovieDetailsState {
  MovieDetailsEntity movieDetails;
  MovieDetailsLoadedState({required this.movieDetails});
}

class MovieDetailsFailureState implements MovieDetailsState {
  final String errorMsg;
  MovieDetailsFailureState({required this.errorMsg});
}