import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

class HomeMovieWidget extends StatefulWidget {
  final MovieEntity movie;
  const HomeMovieWidget({super.key, required this.movie});

  @override
  State<HomeMovieWidget> createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMovieWidget> {
  bool bookmark = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print("${widget.movie.originalTitle}");
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 20.5 / 100,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: Image.network(
                          height: MediaQuery.of(context).size.height * 20 / 100,
                          width: double.infinity,
                          "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 9),
                        Text(
                          "${widget.movie.originalTitle}",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                                text:
                                    "${(widget.movie.popularity ?? 1).round()}",
                                style: TextStyle(
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
                              TextSpan(
                                text: "Year: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextSpan(
                                text: "${widget.movie.releaseDate?.year}",
                                style: TextStyle(
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
            onPressed: () {
              bookmark = !bookmark;
              setState(() {});
            },
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.fromLTRB(0, 0, 2, 14),
            icon: Icon(
              Icons.bookmark,
              size: 31,
              color: bookmark ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
