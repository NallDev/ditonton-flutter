import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    final tMovieList = [testMovieTable];

    test('should clear cache and insert now playing movies into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingMovies(tMovieList);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'now playing')).called(1);
    });
  });

  group('get cached now playing movies', () {
    final tMovieList = [testMovieMap];

    test('should return list of now playing movies when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await dataSource.getCachedNowPlayingMovies();
      // assert
      expect(result, [testMovieTable]);
    });

    test('should throw Exception when there is no data now playing movies in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('cache popular movies', () {
    final tMovieList = [testMovieTable];

    test('should clear cache and insert popular movies into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('popular movies'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'popular movies'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cachePopularMovies(tMovieList);
      // assert
      verify(mockDatabaseHelper.clearCache('popular movies')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'popular movies')).called(1);
    });
  });

  group('get cached popular movies', () {
    final tMovieList = [testMovieMap];

    test('should return list of popular movies when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('popular movies'))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await dataSource.getCachedPopularMovies();
      // assert
      expect(result, [testMovieTable]);
    });

    test('should throw Exception when there is no data popular movies in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('popular movies'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedPopularMovies();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('cache top rated movies', () {
    final tMovieList = [testMovieTable];

    test('should clear cache and insert top rated movies into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('top rated movies'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'top rated movies'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheTopRatedMovies(tMovieList);
      // assert
      verify(mockDatabaseHelper.clearCache('top rated movies')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tMovieList, 'top rated movies')).called(1);
    });
  });

  group('get cached top rated movies', () {
    final tMovieList = [testMovieMap];

    test('should return list of top rated movies when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('top rated movies'))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await dataSource.getCachedTopRatedMovies();
      // assert
      expect(result, [testMovieTable]);
    });

    test('should throw Exception when there is no data top rated movies in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('top rated movies'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('cache now playing series', () {
    final tSeriesList = [testSeriesTable];

    test('should clear cache and insert now playing series into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('now playing series'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'now playing series'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheToNowPlayingSeries(tSeriesList);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing series')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'now playing series')).called(1);
    });
  });

  group('get cached now playing series', () {
    final tSeriesList = [testMovieMap];

    test('should return list of now playing series when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing series'))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await dataSource.getCachedNowPlayingSeries();
      // assert
      expect(result, [testSeriesTable]);
    });

    test('should throw Exception when there is no data now playing series in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing series'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('cache popular series', () {
    final tSeriesList = [testSeriesTable];

    test('should clear cache and insert popular series into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('popular series'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'popular series'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheToPopularSeries(tSeriesList);
      // assert
      verify(mockDatabaseHelper.clearCache('popular series')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'popular series')).called(1);
    });
  });

  group('get cached popular series', () {
    final tSeriesList = [testMovieMap];

    test('should return list of popular series when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('popular series'))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await dataSource.getCachedPopularSeries();
      // assert
      expect(result, [testSeriesTable]);
    });

    test('should throw Exception when there is no data popular series in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('popular series'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedPopularSeries();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('cache top rated series', () {
    final tSeriesList = [testSeriesTable];

    test('should clear cache and insert top rated series into cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('top rated series'))
          .thenAnswer((_) async => 1);
      when(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'top rated series'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheToTopRatedSeries(tSeriesList);
      // assert
      verify(mockDatabaseHelper.clearCache('top rated series')).called(1);
      verify(mockDatabaseHelper.insertCacheTransaction(tSeriesList, 'top rated series')).called(1);
    });
  });

  group('get cached top rated series', () {
    final tSeriesList = [testMovieMap];

    test('should return list of top rated series when there is data in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('top rated series'))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await dataSource.getCachedTopRatedSeries();
      // assert
      expect(result, [testSeriesTable]);
    });

    test('should throw Exception when there is no data top rated series in cache', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('top rated series'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}