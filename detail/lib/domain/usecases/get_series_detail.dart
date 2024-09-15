import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:detail/domain/repositories/detail_repository.dart';
import 'package:core/core.dart';

class GetSeriesDetail {
  final DetailRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
