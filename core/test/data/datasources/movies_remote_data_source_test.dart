import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/movies_remote_data_source.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MoviesRemoteDataSourceImpl dataSource;
  late MockIOClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockIOClient();
    dataSource = MoviesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));
          // act
          final result = await dataSource.getNowPlayingMovies();
          // assert
          expect(result, equals(tMovieList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getNowPlayingMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
          // act
          final result = await dataSource.getPopularMovies();
          // assert
          expect(result, tMovieList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedMovies();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Now Playing Series', () {
    final tSeriesList = SeriesResponse.fromJson(
        json.decode(readJson('dummy_data/airing_today.json')))
        .seriesList;

    test('should return list of Series Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200));
          // act
          final result = await dataSource.getNowPlayingSeries();
          // assert
          expect(result, equals(tSeriesList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getNowPlayingSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Series', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/popular_series.json')))
            .seriesList;

    test('should return list of series when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_series.json'), 200));
          // act
          final result = await dataSource.getPopularSeries();
          // assert
          expect(result, tSeriesList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Series', () {
    final tSeriesList = SeriesResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_series.json')))
        .seriesList;

    test('should return list of series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_series.json'), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedSeries();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}