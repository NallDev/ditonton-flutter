import 'package:core/core.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:dartz/dartz.dart';
import 'package:home/data/datasources/home_local_data_source.dart';
import 'package:home/data/datasources/home_remote_data_source.dart';
import 'package:home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
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
