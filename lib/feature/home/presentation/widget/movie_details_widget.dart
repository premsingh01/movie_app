import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_cubit.dart';
import 'package:movie_app/service_locator.dart';

class MovieDetailsWidget extends StatefulWidget {
  final MovieDetailsEntity movieData;
  const MovieDetailsWidget({super.key, required this.movieData});

  factory MovieDetailsWidget.fromMovieEntity(MovieEntity movie) {
    return MovieDetailsWidget(
      movieData: MovieDetailsEntity(
        id: movie.id,
        backdropPath: movie.backdropPath,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        title: movie.title,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      ),
    );
  }

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  bool _bookmarked = false;

  @override
  void initState() {
    super.initState();
    _initBookmark();
  }

  Future<void> _initBookmark() async {
    final id = widget.movieData.id;
    if (id != null) {
      final saved = await sl<SavedCubit>().isSaved(id);
      if (mounted) {
        setState(() => _bookmarked = saved);
      }
    }
  }

  Future<void> _toggleBookmark() async {
    final id = widget.movieData.id;
    if (id == null) return;
    await sl<SavedCubit>().toggleBookmarkFromEntity(widget.movieData);
    if (mounted) {
      setState(() => _bookmarked = !_bookmarked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: _toggleBookmark,
              icon: Icon(
                Icons.bookmark,
                color: _bookmarked ? Colors.red : Colors.grey,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ), // .horizontal(left: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl:
                  "https://image.tmdb.org/t/p/w500${widget.movieData.backdropPath}",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ), // while loading
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red), // if failed
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "${widget.movieData.originalTitle}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
          ),
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Popularity: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextSpan(
                  text: "${(widget.movieData.popularity ?? 1).round()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Year: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextSpan(
                  text: "${widget.movieData.releaseDate?.year}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: List.generate(
              ((widget.movieData.voteAverage ?? 2) / 2).round(),
              (index) => const Icon(Icons.star, color: Colors.amber, size: 27),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "${widget.movieData.overview}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
