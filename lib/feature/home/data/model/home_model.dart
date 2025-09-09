import 'package:movie_app/feature/home/domain/entity/home_entity.dart';

class HomeModel extends HomeEntity {    
    HomeModel({
        required super.page,
        required super.movieList,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        page: json["page"],
        movieList: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from((movieList as List<Movie>).map((x) => x.toJson())),
    };
}

class Movie  extends MovieEntity{
    Movie({
        super.adult,
        super.backdropPath,
        super.genreIds,
        super.id,
        super.originalLanguage,
        super.originalTitle,
        super.overview,
        super.popularity,
        super.posterPath,
        super.releaseDate,
        super.title,
        super.video,
        super.voteAverage,
        super.voteCount,
    });

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
