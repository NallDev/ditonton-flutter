import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/core.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, MovieDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Movie>>> getSeriesRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
}
