
class HomeEntity {
    int page;
    List<MovieEntity> movieList;

    HomeEntity({
        required this.page,
        required this.movieList,
    });
}

class MovieEntity {
    bool? adult;
    String? backdropPath;
    int? id;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieEntity({
         this.adult,
         this.backdropPath,
         this.id,
         this.originalLanguage,
         this.originalTitle,
         this.overview,
         this.popularity,
         this.posterPath,
         this.releaseDate,
         this.title,
         this.video,
         this.voteAverage,
         this.voteCount,
    });
}
