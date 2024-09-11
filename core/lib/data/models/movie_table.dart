import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

import '../../domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final bool isSeries;

  MovieTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.isSeries});

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        isSeries: movie.isSeries,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      isSeries: map['isSeries'] == 1 ? true : false);

  factory MovieTable.fromDTOMovie(MovieModel movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      isSeries: false);

  factory MovieTable.fromDTOSeries(SeriesModel series) => MovieTable(
      id: series.id,
      title: series.name,
      posterPath: series.posterPath,
      overview: series.overview,
      isSeries: true);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isSeries': isSeries ? 1 : 0
      };

  Movie toEntity() => Movie.watchlist(
      id: id,
      overview: overview,
      posterPath: posterPath,
      title: title,
      isSeries: isSeries);

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
