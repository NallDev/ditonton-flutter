import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:search/data/datasources/search_remote_data_source.dart';
import 'package:search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final resultMovie = await remoteDataSource.searchMovies(query);
      final resultSeries = await remoteDataSource.searchSeries(query);

      final movieList = resultMovie.map((model) => model.toEntity()).toList();
      final seriesList = resultSeries.map((model) => model.toEntity()).toList();
      final movieCombine = [...seriesList, ...movieList];

      return Right(movieCombine);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}