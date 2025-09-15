import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/presentation/widget/movie_details_widget.dart';

class MovieDetailView extends StatefulWidget {
  final MovieEntity movie;
  const MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Details")),
      body: MovieDetailsWidget.fromMovieEntity(widget.movie),
    );
  }
}
