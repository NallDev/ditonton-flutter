import 'package:dartz/dartz.dart';
import 'package:detail/domain/repositories/detail_repository.dart';
import 'package:core/core.dart';

class GetSeriesRecommendations {
  final DetailRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
