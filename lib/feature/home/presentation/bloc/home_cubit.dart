import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase usecase;
  HomeCubit(this.usecase) : super(HomeInitialState());

  Future<void> getMovies() async {
    emit(HomeLoadingState());
    final result = await usecase();
    result.when(
      ok: (p0) => emit(HomeLoadedState(movieData: p0)),
      err: (error) => emit(HomeFailureState(errorMsg: error.error.toString())),
    );
  }
}
