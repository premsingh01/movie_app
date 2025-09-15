import 'package:movie_app/feature/home/data/model/home_model.dart';

class SearchModel extends HomeModel {
  SearchModel({
    required super.page,
    required super.movieList,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        page: json["page"],
        movieList: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from((movieList as List<Movie>).map((x) => x.toJson())),
      };
}
