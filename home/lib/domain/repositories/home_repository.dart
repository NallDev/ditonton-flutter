import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getNowPlayingSeries();
  Future<Either<Failure, List<Movie>>> getPopularSeries();
  Future<Either<Failure, List<Movie>>> getTopRatedSeries();
}