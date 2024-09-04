import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetNowPlayingSeries {
  final MovieRepository repository;

  GetNowPlayingSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingSeries();
  }
}
