import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_cubit.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/presentation/page/movie_detail_view.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_cubit.dart';

class HomePosterTile extends StatefulWidget {
  final MovieEntity movie;
  final double width;
  final double height;

  const HomePosterTile({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });

  @override
  State<HomePosterTile> createState() => _HomePosterTileState();
}

class _HomePosterTileState extends State<HomePosterTile> {
  bool _bookmarked = false;

  @override
  void initState() {
    super.initState();
    _initBookmark();
  }

  Future<void> _initBookmark() async {
    final id = widget.movie.id;
    if (id != null) {
      final saved = await sl<SavedCubit>().isSaved(id);
      if (mounted) {
        setState(() => _bookmarked = saved);
      }
    }
  }

  Future<void> _toggleBookmark() async {
    final id = widget.movie.id;
    if (id == null) return;

    await sl<SavedCubit>().toggleBookmarkFromEntity(widget.movie);
    if (mounted) {
      setState(() => _bookmarked = !_bookmarked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailView(movie: widget.movie),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: _toggleBookmark,
                child: Icon(
                  Icons.bookmark,
                  color: _bookmarked ? Colors.red : Colors.white70,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: widget.width,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Text(
                  widget.movie.title ?? widget.movie.originalTitle ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


