import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getNowPlayingMovies();
        localDataSource.cacheNowPlayingMovies(
            resultNetwork.map((movie) => MovieTable.fromDTOMovie(movie)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedNowPlayingMovies();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getPopularMovies();
        localDataSource.cachePopularMovies(
            resultNetwork.map((movie) => MovieTable.fromDTOMovie(movie)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedPopularMovies();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getTopRatedMovies();
        localDataSource.cacheTopRatedMovies(
            resultNetwork.map((movies) => MovieTable.fromDTOMovie(movies)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedTopRatedMovies();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getNowPlayingSeries();
        localDataSource.cacheToNowPlayingSeries(
            resultNetwork.map((movie) => MovieTable.fromDTOSeries(movie)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedNowPlayingSeries();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getPopularSeries();
        localDataSource.cacheToPopularSeries(
            resultNetwork.map((movie) => MovieTable.fromDTOSeries(movie)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedPopularSeries();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final resultNetwork = await remoteDataSource.getTopRatedSeries();
        localDataSource.cacheToTopRatedSeries(
            resultNetwork.map((movie) => MovieTable.fromDTOSeries(movie)).toList());

        return Right(resultNetwork.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final resultLocal = await localDataSource.getCachedTopRatedSeries();
        return Right(resultLocal.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(DatabaseFailure('No Cache'));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result =
      await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result =
      await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }
}