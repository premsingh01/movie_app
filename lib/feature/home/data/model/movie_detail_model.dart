import 'dart:convert';

import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart' as movie_details_entity;

class MovieDetailsModel extends movie_details_entity.MovieDetailsEntity {

    MovieDetailsModel({
        super.adult,
        super.backdropPath,
        super.belongsToCollection,
        super.budget,
        super.genres,
        super.homepage,
        super.id,
        super.imdbId,
        super.originCountry,
        super.originalLanguage,
        super.originalTitle,
        super.overview,
        super.popularity,
        super.posterPath,
        super.productionCompanies,
        super.productionCountries,
        super.releaseDate,
        super.revenue,
        super.runtime,
        super.spokenLanguages,
        super.status,
        super.tagline,
        super.title,
        super.video,
        super.voteAverage,
        super.voteCount,
    });

    factory MovieDetailsModel.fromRawJson(String str) => MovieDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] == null ? null : BelongsToCollection.fromJson(json["belongs_to_collection"]),
        budget: json["budget"],
        genres: json["genres"] == null ? [] : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null ? [] : List<ProductionCompany>.from(json["production_companies"]!.map((x) => ProductionCompany.fromJson(x))),
        productionCountries: json["production_countries"] == null ? [] : List<ProductionCountry>.from(json["production_countries"]!.map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: json["spoken_languages"] == null ? [] : List<SpokenLanguage>.from(json["spoken_languages"]!.map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null ? [] : List<dynamic>.from(productionCompanies!.map((x) => x)),
        "production_countries": productionCountries == null ? [] : List<dynamic>.from(productionCountries!.map((x) => x)),
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spokenLanguages == null ? [] : List<dynamic>.from(spokenLanguages!.map((x) => x)),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class BelongsToCollection extends movie_details_entity.BelongsToCollection {

    BelongsToCollection({
        super.id,
        super.name,
        super.posterPath,
        super.backdropPath,
    });

    factory BelongsToCollection.fromRawJson(String str) => BelongsToCollection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
    };
}

class Genre  extends movie_details_entity.Genre {

    Genre({
        super.id,
        super.name,
    });

    factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ProductionCompany extends movie_details_entity.ProductionCompany {

    ProductionCompany({
        super.id,
        super.logoPath,
        super.name,
        super.originCountry,
    });

    factory ProductionCompany.fromRawJson(String str) => ProductionCompany.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountry extends movie_details_entity.ProductionCountry {

    ProductionCountry({
        super.iso31661,
        super.name,
    });

    factory ProductionCountry.fromRawJson(String str) => ProductionCountry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage extends movie_details_entity.SpokenLanguage {

    SpokenLanguage({
        super.englishName,
        super.iso6391,
        super.name,
    });

    factory SpokenLanguage.fromRawJson(String str) => SpokenLanguage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
