import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase usecase;
  HomeCubit(this.usecase) : super(HomeInitialState());

  Future<void> getMovies() async {
    emit(HomeLoadingState());
    final results = await Future.wait([
      usecase.fetchTrending(),
      usecase.fetchNowPlaying(),
    ]);

    final trendingResult = results[0];
    final nowPlayingResult = results[1];

    if (trendingResult.isOk() && nowPlayingResult.isOk()) {
      emit(
        HomeLoadedState(
          trending: trendingResult.unwrap(),
          nowPlaying: nowPlayingResult.unwrap(),
        ),
      );
    } else {
      final errorMsg = trendingResult.isErr()
          ? trendingResult.unwrapErr().error.toString()
          : nowPlayingResult.unwrapErr().error.toString();
      emit(HomeFailureState(errorMsg: errorMsg));
    }
  }
}
