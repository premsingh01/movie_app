import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_cubit.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';
import 'package:movie_app/feature/home/presentation/widget/home_movie_widget.dart';
import 'package:movie_app/service_locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 27, color: Colors.white),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => sl<HomeCubit>()..getMovies(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              switch (state) {
                case HomeInitialState():
                  return SizedBox();
                case HomeLoadingState():
                  return Center(child: CircularProgressIndicator());
                case HomeLoadedState():
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 13),
                    shrinkWrap: true,
                    itemCount: state.movieData.movieList.length,
                    itemBuilder: (context, index) {
                      return HomeMovieWidget(
                        movie: state.movieData.movieList[index],
                      );
                    },
                  );
                case HomeFailureState():
                  return Text(state.errorMsg);
              }
            },
          ),
        ),
      ),
    );
  }
}
