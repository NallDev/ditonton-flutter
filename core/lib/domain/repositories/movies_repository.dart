import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getNowPlayingSeries();
  Future<Either<Failure, List<Movie>>> getPopularSeries();
  Future<Either<Failure, List<Movie>>> getTopRatedSeries();
}