import 'dart:convert';

import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/models/series_response.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<SeriesModel>> getNowPlayingSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {

  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getNowPlayingSeries() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}