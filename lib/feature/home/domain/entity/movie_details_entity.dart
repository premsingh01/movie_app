
class MovieDetailsEntity {
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

    MovieDetailsEntity({
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
    });}

class BelongsToCollection {
    int? id;
    String? name;
    String? posterPath;
    String? backdropPath;

    BelongsToCollection({
        this.id,
        this.name,
        this.posterPath,
        this.backdropPath,
    });
    }

class Genre {
    int? id;
    String? name;

    Genre({
        this.id,
        this.name,
    });
}

class ProductionCompany {
    int? id;
    String? logoPath;
    String? name;
    String? originCountry;

    ProductionCompany({
        this.id,
        this.logoPath,
        this.name,
        this.originCountry,
    });
}

class ProductionCountry {
    String? iso31661;
    String? name;

    ProductionCountry({
        this.iso31661,
        this.name,
    });
}

class SpokenLanguage {
    String? englishName;
    String? iso6391;
    String? name;

    SpokenLanguage({
        this.englishName,
        this.iso6391,
        this.name,
    });
}
