


import 'package:bloc/bloc.dart';
import 'package:movie_app/feature/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitialState());

  void changeIndex({required int index}) {
    emit(DashboardLoadedState(index));
  }
}