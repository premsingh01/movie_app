import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({required super.page, required super.movieList});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    page: json["page"],
    movieList: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from((movieList as List<Movie>).map((x) => x.toJson())),
  };
}

class Movie extends MovieEntity {
  Movie({
    super.backdropPath,
    super.id,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.releaseDate,
    super.title,
    super.voteAverage,
    super.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    backdropPath: json["backdrop_path"],
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    releaseDate: DateTime.tryParse(json["release_date"]),
    title: json["title"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
    "title": title,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
