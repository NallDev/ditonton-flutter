import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    isSeries: false,
  );

  final tSeriesTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    isSeries: true,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [
      Genre(id: 1, name: 'Action'),
    ],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 8.0,
    voteCount: 1000,
    isSeries: false,
  );

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovie = Movie.watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    isSeries: false,
  );

  final tMap = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
    'isSeries': 0,
  };

  group('fromEntity', () {
    test('should return a valid model from MovieDetail entity', () async {
      // arrange

      // act
      final result = MovieTable.fromEntity(tMovieDetail);

      // assert
      expect(result, tMovieTable);
    });
  });

  group('fromMap', () {
    test('should return a valid model from map', () async {
      // arrange

      // act
      final result = MovieTable.fromMap(tMap);

      // assert
      expect(result, tMovieTable);
    });
  });

  group('fromDTOMovie', () {
    test('should return a valid model from MovieModel', () async {
      // arrange

      // act
      final result = MovieTable.fromDTOMovie(tMovieModel);

      // assert
      expect(result, tMovieTable);
    });
  });

  group('fromDTOSeries', () {
    test('should return a valid model from SeriesModel', () async {
      // arrange

      // act
      final result = MovieTable.fromDTOSeries(tSeriesModel);

      // assert
      expect(result, tSeriesTable);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieTable.toJson();

      // assert
      expect(result, tMap);
    });
  });

  group('toEntity', () {
    test('should return a Movie entity from MovieTable', () async {
      // arrange

      // act
      final result = tMovieTable.toEntity();

      // assert
      expect(result, tMovie);
    });
  });
}