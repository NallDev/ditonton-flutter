import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetSeriesRecommendations {
  final MovieRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
