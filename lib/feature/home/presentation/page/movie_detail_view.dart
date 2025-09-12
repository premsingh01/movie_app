import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/presentation/bloc/movie_detail_cubit.dart';
import 'package:movie_app/feature/home/presentation/bloc/movie_detail_state.dart';
import 'package:movie_app/service_locator.dart';

class MovieDetailView extends StatefulWidget {
  final int movieId;
  const MovieDetailView({super.key, required this.movieId});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsCubit>()..getMovieDetails(movieId: widget.movieId),
      child: Scaffold(
        appBar: AppBar(title: const Text("Movie Details")),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            switch(state) {
              case MovieDetailsInitialState():
                return SizedBox.shrink();
              case MovieDetailsLoadingState():
                return Center(child: CircularProgressIndicator());
              case MovieDetailsLoadedState():
                return Text(state.movieDetails.originalTitle ?? '');
              case MovieDetailsFailureState():
                return Text(state.errorMsg);
            }
          }
          ),
      ),
    );
  }
}
