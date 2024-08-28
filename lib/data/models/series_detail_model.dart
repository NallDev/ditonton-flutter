import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesDetailResponse extends Equatable {
  SeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalTitle: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["first_air_date"],
        title: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_name": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "first_air_date": releaseDate,
        "name": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  MovieDetail toEntity() {
    return MovieDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalTitle: this.originalTitle,
      overview: this.overview,
      posterPath: this.posterPath,
      releaseDate: this.releaseDate,
      runtime: 0,
      title: this.title,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      isSeries: true
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
      ];
}
