import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';

class MovieDetailsWidget extends StatefulWidget {
  final MovieDetailsEntity movieData;
  const MovieDetailsWidget({super.key, required this.movieData});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
