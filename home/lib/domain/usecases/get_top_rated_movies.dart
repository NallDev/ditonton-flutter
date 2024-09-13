import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:home/domain/repositories/home_repository.dart';

class GetTopRatedMovies {
  final HomeRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
