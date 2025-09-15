import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_cubit.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/presentation/page/movie_detail_view.dart';
import 'package:movie_app/service_locator.dart';

class SearchMovieWidget extends StatefulWidget {
  final MovieEntity movie;
  
  const SearchMovieWidget({super.key, required this.movie});

  @override
  State<SearchMovieWidget> createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  bool bookmark = false;
  
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
        setState(() {
          bookmark = saved;
        });
      }
    }
  }

  Future<void> _toggleBookmark() async {
    final id = widget.movie.id;
    if (id == null) return;

    await sl<SavedCubit>().toggleBookmarkFromEntity(widget.movie);
    if (mounted) {
      setState(() {
        bookmark = !bookmark;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell      (
      highlightColor: Colors.grey.shade700,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_) => MovieDetailView(movieId: widget.movie.id ?? 0),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade800),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.sizeOf(context).height * 20.5 / 100,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 9),
                        Text(
                          "${widget.movie.originalTitle}",
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Popularity: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextSpan(
                                text: "${(widget.movie.popularity ?? 1).round()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Year: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextSpan(
                                text: "${widget.movie.releaseDate?.year}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            ((widget.movie.voteAverage ?? 2) / 2).round(),
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 27,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _toggleBookmark,            
            icon: Icon(
              Icons.bookmark,
              size: 31,
              color: bookmark ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
