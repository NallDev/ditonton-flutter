import 'dart:convert';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [
      GenreModel(id: 1, name: 'Action'),
    ],
    homepage: 'http://example.com',
    id: 1,
    imdbId: '123',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: '2024-08-01',
    revenue: 1,
    runtime: 1,
    status: 'released',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
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
    releaseDate: '2024-08-01',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
    isSeries: false,
  );

  group('toEntity', () {
    test('should return a valid MovieDetail entity', () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toEntity();

      // assert
      expect(result, tMovieDetail);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/movie_detail_model.json'));

      // act
      final result = MovieDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, tMovieDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toJson();

      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "budget": 1,
        "genres": [
          {"id": 1, "name": "Action"},
        ],
        "homepage": "http://example.com",
        "id": 1,
        "imdb_id": "123",
        "original_language": "en",
        "original_title": "originalTitle",
        "overview": "overview",
        "popularity": 1.0,
        "poster_path": "posterPath",
        "release_date": "2024-08-01",
        "revenue": 1,
        "runtime": 1,
        "status": "released",
        "tagline": "tagline",
        "title": "title",
        "video": false,
        "vote_average": 1.0,
        "vote_count": 1,
      };

      expect(result, expectedJsonMap);
    });
  });
}
