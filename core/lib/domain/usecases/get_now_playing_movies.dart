import 'package:core/domain/repositories/movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetNowPlayingMovies {
  final MoviesRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
