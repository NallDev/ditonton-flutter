import '../db/database_helper.dart';
import '../models/movie_table.dart';

abstract class MoviesLocalDataSource {
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<void> cachePopularMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedPopularMovies();
  Future<void> cacheTopRatedMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedTopRatedMovies();
  Future<void> cacheToNowPlayingSeries(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingSeries();
  Future<void> cacheToPopularSeries(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedPopularSeries();
  Future<void> cacheToTopRatedSeries(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedTopRatedSeries();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource{
  final DatabaseHelper databaseHelper;

  MoviesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('popular movies');
    await databaseHelper.insertCacheTransaction(movies, 'popular movies');
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    final result = await databaseHelper.getCacheMovies('popular movies');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('top rated movies');
    await databaseHelper.insertCacheTransaction(movies, 'top rated movies');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    final result = await databaseHelper.getCacheMovies('top rated movies');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheToNowPlayingSeries(List<MovieTable> movies) async  {
    await databaseHelper.clearCache('now playing series');
    await databaseHelper.insertCacheTransaction(movies, 'now playing series');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingSeries() async  {
    final result = await databaseHelper.getCacheMovies('now playing series');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheToPopularSeries(List<MovieTable> movies) async  {
    await databaseHelper.clearCache('popular series');
    await databaseHelper.insertCacheTransaction(movies, 'popular series');
  }

  @override
  Future<List<MovieTable>> getCachedPopularSeries() async  {
    final result = await databaseHelper.getCacheMovies('popular series');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheToTopRatedSeries(List<MovieTable> movies) async  {
    await databaseHelper.clearCache('top rated series');
    await databaseHelper.insertCacheTransaction(movies, 'top rated series');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedSeries() async  {
    final result = await databaseHelper.getCacheMovies('top rated series');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw Exception("Can't get the data :(");
    }
  }
}