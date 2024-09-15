import 'package:dartz/dartz.dart';
import 'package:detail/domain/repositories/detail_repository.dart';
import 'package:core/core.dart';

class GetMovieRecommendations {
  final DetailRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
