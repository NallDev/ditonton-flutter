import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final num? voteAverage;
  final int? voteCount;

  SeriesModel(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.firstAirDate,
      required this.name,
      required this.voteAverage,
      required this.voteCount});

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Movie toEntity() {
    return Movie(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalTitle: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      releaseDate: this.firstAirDate,
      title: this.name,
      video: false,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      isSeries: true,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
