import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetTopRatedSeries {
  final MovieRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedSeries();
  }
}
