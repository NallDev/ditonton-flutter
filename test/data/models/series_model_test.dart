import 'dart:convert';

import 'package:ditonton/data/models/series_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originCountry: ['a', 'b', 'c'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1.0,
      voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'firstAirDate',
    title: 'name',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
    isSeries: true,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tMovie);
  });


  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/series.json'));
      // act
      final result = SeriesModel.fromJson(jsonMap);
      // assert
      expect(result, tSeriesModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "genre_ids": [1, 2, 3],
        "id": 1,
        "origin_country": ["a", "b", "c"],
        "original_language": "originalLanguage",
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 1.0,
        "poster_path": "posterPath",
        "first_air_date": "firstAirDate",
        "name": "name",
        "vote_average": 1.0,
        "vote_count": 1
      };

      expect(result, expectedJsonMap);
    });
  });
}