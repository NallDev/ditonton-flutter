import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<SeriesModel>> searchSeries(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {

  late final IOClient client;

  SearchRemoteDataSourceImpl() {
    _initializeHttpClient();
  }

  Future<void> _initializeHttpClient() async {
    final sslCert = await rootBundle.load('packages/search/assets/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    this.client = IOClient(client);
  }

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