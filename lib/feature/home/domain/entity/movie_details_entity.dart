
class MovieDetailsEntity {
    bool? adult;
    String? backdropPath;
    BelongsToCollection? belongsToCollection;
    int? budget;
    List<Genre>? genres;
    String? homepage;
    int? id;
    String? imdbId;
    List<String>? originCountry;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    List<ProductionCompany>? productionCompanies;
    List<ProductionCountry>? productionCountries;
    DateTime? releaseDate;
    int? revenue;
    int? runtime;
    List<SpokenLanguage>? spokenLanguages;
    String? status;
    String? tagline;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieDetailsEntity({
        this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originCountry,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
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
