import 'dart:convert';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/series_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesDetailResponse = SeriesDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [
      GenreModel(id: 1, name: 'Action'),
    ],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2024-08-01',
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tSeriesDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [
      Genre(id: 1, name: 'Action'),
    ],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2024-08-01',
    runtime: 0,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
    isSeries: true,
  );

  group('toEntity', () {
    test('should return a valid MovieDetail entity', () async {
      // arrange

      // act
      final result = tSeriesDetailResponse.toEntity();

      // assert
      expect(result, tSeriesDetail);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/series_detail_model.json'));

      // act
      final result = SeriesDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, tSeriesDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesDetailResponse.toJson();

      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "genres": [
          {"id": 1, "name": "Action"},
        ],
        "id": 1,
        "original_name": "originalTitle",
        "overview": "overview",
        "poster_path": "posterPath",
        "first_air_date": "2024-08-01",
        "name": "title",
        "vote_average": 1.0,
        "vote_count": 1,
      };

      expect(result, expectedJsonMap);
    });
  });
}
