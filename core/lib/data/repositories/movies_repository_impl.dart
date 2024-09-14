import 'package:core/data/datasources/movies_local_data_source.dart';
import 'package:core/data/datasources/movies_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../../utils/network_info.dart';
import '../models/movie_table.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl({
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
}