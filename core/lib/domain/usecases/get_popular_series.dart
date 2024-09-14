import 'package:core/domain/repositories/movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetPopularSeries {
  final MoviesRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularSeries();
  }
}
