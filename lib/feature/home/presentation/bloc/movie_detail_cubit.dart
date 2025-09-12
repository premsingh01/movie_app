



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/domain/usecase/movie_detail_usecase.dart';
import 'package:movie_app/feature/home/presentation/bloc/movie_detail_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailUsecase movieDetailUsecase;
  MovieDetailsCubit(this.movieDetailUsecase) : super(MovieDetailsInitialState());

  Future<void> getMovieDetails({required int movieId}) async {
    emit(MovieDetailsLoadingState());
    final result = await movieDetailUsecase(movieId: movieId);
    result.when(
      ok: (p0) => emit(MovieDetailsLoadedState(movieDetails: p0)),
      err: (error) => emit(MovieDetailsFailureState(errorMsg: error.error.toString())),
    );
  }


}