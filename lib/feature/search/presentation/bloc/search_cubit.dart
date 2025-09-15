import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/search/domain/usecase/search_usecase.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUsecase usecase;
  
  SearchCubit(this.usecase) : super(SearchInitialState());

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());
    
    final result = await usecase.searchMovies(query);
    
    result.when(
      ok: (homeEntity) {
        if (homeEntity.movieList.isEmpty) {
          emit(SearchEmptyState(query: query));
        } else {
          emit(SearchLoadedState(movieList: homeEntity.movieList, query: query));
        }
      },
      err: (error) => emit(SearchFailureState(errorMsg: error)),
    );
  }

  void clearSearch() {
    emit(SearchInitialState());
  }
}
