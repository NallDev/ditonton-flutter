import 'package:core/data/db/database_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';

@GenerateMocks([
  DatabaseHelper,
  WatchlistLocalDataSource,
  WatchlistRepository,
  GetWatchlistMovies,
])
void main() {}