import 'package:core/data/datasources/movies_local_data_source.dart';
import 'package:core/data/datasources/movies_remote_data_source.dart';
import 'package:core/data/db/database_helper.dart';
import 'package:core/domain/repositories/movies_repository.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_now_playing_series.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_series.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_series.dart';
import 'package:core/utils/network_info.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  IOClient,
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  NetworkInfo,
  MoviesRepository,
  GetNowPlayingMovies,
  GetNowPlayingSeries,
  GetPopularMovies,
  GetPopularSeries,
  GetTopRatedMovies,
  GetTopRatedSeries
])
void main() {}