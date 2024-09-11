import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}