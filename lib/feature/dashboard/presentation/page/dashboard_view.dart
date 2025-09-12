import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:movie_app/feature/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:movie_app/feature/home/presentation/page/home_view.dart';
import 'package:movie_app/service_locator.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    const Center(child: Text("Search Page", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Saved Page", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardCubit>()..changeIndex(index: 0),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          switch (state) {
            case DashboardInitialState():
              return const SizedBox.shrink();
            case DashboardLoadingState():
              return const SizedBox.shrink();
            case DashboardLoadedState():
              return Scaffold(
                body: IndexedStack(index: state.index, children: _pages),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  selectedItemColor: Colors.red,
                  onTap: (index) {
                    context.read<DashboardCubit>().changeIndex(index: index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark),
                      label: "Saved",
                    ),
                  ],
                ),
              );
            case DashboardFailureState():
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
