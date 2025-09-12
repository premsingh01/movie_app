


sealed class DashboardState {}

class DashboardInitialState implements DashboardState {}

class DashboardLoadingState implements DashboardState {}

class DashboardLoadedState implements DashboardState {
  final int index;
  DashboardLoadedState(this.index);
}

class DashboardFailureState implements DashboardState {}