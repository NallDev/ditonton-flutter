import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:home/domain/repositories/home_repository.dart';

class GetPopularSeries {
  final HomeRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularSeries();
  }
}
