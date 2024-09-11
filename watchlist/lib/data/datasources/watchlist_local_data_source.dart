import 'package:core/data/db/database_helper.dart';
import 'package:core/data/models/movie_table.dart';

abstract class WatchlistLocalDataSource {
  Future<List<MovieTable>> getWatchlistMovies();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}