import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

import '../../utils/constants.dart';
import '../../utils/exception.dart';
import '../models/movie_model.dart';
import '../models/movie_response.dart';
import '../models/series_model.dart';

import '../models/series_response.dart';

abstract class MoviesRemoteDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<SeriesModel>> getNowPlayingSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {

  late final IOClient client;

  MoviesRemoteDataSourceImpl({required this.client});

  static Future<MoviesRemoteDataSourceImpl> create() async {
    final sslCert = await rootBundle.load('packages/core/assets/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    final ioClient = IOClient(httpClient);

    return MoviesRemoteDataSourceImpl(client: ioClient);
  }

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