import 'dart:convert';

import 'package:core/core.dart';

import 'package:http/http.dart' as http;

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<SeriesModel>> searchSeries(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {

  final http.Client client;

  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}