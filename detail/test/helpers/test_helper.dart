import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:detail/data/datasources/detail_local_data_source.dart';
import 'package:detail/data/datasources/detail_remote_data_source.dart';
import 'package:detail/domain/repositories/detail_repository.dart';
import 'package:detail/domain/usecases/get_movie_detail.dart';
import 'package:detail/domain/usecases/get_movie_recommendations.dart';
import 'package:detail/domain/usecases/get_series_detail.dart';
import 'package:detail/domain/usecases/get_series_recommendations.dart';
import 'package:detail/domain/usecases/get_watchlist_status.dart';
import 'package:detail/domain/usecases/remove_watchlist.dart';
import 'package:detail/domain/usecases/save_watchlist.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  IOClient,
  DetailRepository,
  DetailRemoteDataSource,
  DetailLocalDataSource,
  NetworkInfo,
  GetMovieDetail,
  GetSeriesDetail,
  GetMovieRecommendations,
  GetSeriesRecommendations,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchListStatus
])
void main() {}