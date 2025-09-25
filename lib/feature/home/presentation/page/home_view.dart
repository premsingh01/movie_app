import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_cubit.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';
import 'package:movie_app/feature/home/presentation/widget/home_movie_widget.dart';
import 'package:movie_app/feature/home/presentation/widget/home_poster_tile.dart';
import 'package:movie_app/service_locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: BlocProvider(
          create: (context) => sl<HomeCubit>()..getMovies(),
          child: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async {
                            await context.read<HomeCubit>().getMovies();
                          },
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state) {
                      case HomeInitialState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      case HomeLoadingState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      case HomeLoadedState():
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                "Now Playing",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: (() {
                                  final screenWidth = MediaQuery.sizeOf(context).width;
                                  const spacing = 12.0;
                                  final available = screenWidth - 40; // horizontal padding 20 + 20
                                  final itemWidth = (available - spacing * 3) / 3.5;
                                  final itemHeight = itemWidth / 0.66; // match poster aspect ratio
                                  return itemHeight;
                                })(),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                                  itemCount: state.nowPlaying.length,
                                  itemBuilder: (context, index) {
                                    final screenWidth = MediaQuery.sizeOf(context).width;
                                    const spacing = 12.0;
                                    final available = screenWidth - 40;
                                    final itemWidth = (available - spacing * 3) / 3.5;
                                    final itemHeight = itemWidth / 0.66;
                                    return HomePosterTile(
                                      movie: state.nowPlaying[index],
                                      width: itemWidth,
                                      height: itemHeight,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Trending Movies",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.66,
                                ),
                                itemCount: state.trending.length,
                                itemBuilder: (context, index) {
                                  final tileWidth = (MediaQuery.sizeOf(context).width - 20 - 20 - 12) / 2; // padding and spacing
                                  final tileHeight = tileWidth / 0.66;
                                  return HomePosterTile(
                                    movie: state.trending[index],
                                    width: tileWidth,
                                    height: tileHeight,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      case HomeFailureState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 120),
                            Center(child: Text(state.errorMsg)),
                          ],
                        );
                    }
                  },
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
