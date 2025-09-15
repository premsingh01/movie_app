import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

sealed class SavedState {}

class SavedInitialState implements SavedState {}

class SavedLoadingState implements SavedState {}

class SavedLoadedState implements SavedState {
  final List<MovieEntity> movieList;
  SavedLoadedState({required this.movieList});
}

class SavedEmptyState implements SavedState {}

class SavedFailureState implements SavedState {
  final String errorMsg;
  SavedFailureState({required this.errorMsg});
}
