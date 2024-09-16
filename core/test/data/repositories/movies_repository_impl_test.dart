import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/repositories/movies_repository_impl.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockRemoteDataSource;
  late MockMoviesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMoviesRemoteDataSource();
    mockLocalDataSource = MockMoviesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MoviesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: '2024-08-01',
    name: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    isSeries: false,
  );

  final tSeries = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: '2024-08-01',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
      isSeries: true
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  final tSeriesModelList = <SeriesModel>[tSeriesModel];
  final tSeriesList = <Movie>[tSeries];

  group('Now Playing Movies', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => []);
      // act
      await repository.getNowPlayingMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            final result = await repository.getNowPlayingMovies();
            // assert
            verify(mockRemoteDataSource.getNowPlayingMovies());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tMovieList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            await repository.getNowPlayingMovies();
            // assert
            verify(mockRemoteDataSource.getNowPlayingMovies());
            verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingMovies())
                .thenThrow(ServerException());
            // act
            final result = await repository.getNowPlayingMovies();
            // assert
            verify(mockRemoteDataSource.getNowPlayingMovies());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingMovies())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });

  group('Popular Movies', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => []);
      // act
      await repository.getPopularMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            final result = await repository.getPopularMovies();
            // assert
            verify(mockRemoteDataSource.getPopularMovies());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tMovieList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            await repository.getPopularMovies();
            // assert
            verify(mockRemoteDataSource.getPopularMovies());
            verify(mockLocalDataSource.cachePopularMovies([testMovieCache]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularMovies())
                .thenThrow(ServerException());
            // act
            final result = await repository.getPopularMovies();
            // assert
            verify(mockRemoteDataSource.getPopularMovies());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockLocalDataSource.getCachedPopularMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularMovies())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockLocalDataSource.getCachedPopularMovies());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });

  group('Top Rated Movies', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => []);
      // act
      await repository.getTopRatedMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            final result = await repository.getTopRatedMovies();
            // assert
            verify(mockRemoteDataSource.getTopRatedMovies());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tMovieList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedMovies())
                .thenAnswer((_) async => tMovieModelList);
            // act
            await repository.getTopRatedMovies();
            // assert
            verify(mockRemoteDataSource.getTopRatedMovies());
            verify(mockLocalDataSource.cacheTopRatedMovies([testMovieCache]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedMovies())
                .thenThrow(ServerException());
            // act
            final result = await repository.getTopRatedMovies();
            // assert
            verify(mockRemoteDataSource.getTopRatedMovies());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedMovies())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });

  group('Now Playing Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getNowPlayingSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            final result = await repository.getNowPlayingSeries();
            // assert
            verify(mockRemoteDataSource.getNowPlayingSeries());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tSeriesList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            await repository.getNowPlayingSeries();
            // assert
            verify(mockRemoteDataSource.getNowPlayingSeries());
            verify(mockLocalDataSource.cacheToNowPlayingSeries([testMovieTable]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getNowPlayingSeries())
                .thenThrow(ServerException());
            // act
            final result = await repository.getNowPlayingSeries();
            // assert
            verify(mockRemoteDataSource.getNowPlayingSeries());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingSeries())
            .thenAnswer((_) async => [testSeriesTable]);
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingSeries())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingSeries());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });

  group('Popular Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getPopularSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            final result = await repository.getPopularSeries();
            // assert
            verify(mockRemoteDataSource.getPopularSeries());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tSeriesList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            await repository.getPopularSeries();
            // assert
            verify(mockRemoteDataSource.getPopularSeries());
            verify(mockLocalDataSource.cacheToPopularSeries([testMovieTable]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getPopularSeries())
                .thenThrow(ServerException());
            // act
            final result = await repository.getPopularSeries();
            // assert
            verify(mockRemoteDataSource.getPopularSeries());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularSeries())
            .thenAnswer((_) async => [testSeriesTable]);
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockLocalDataSource.getCachedPopularSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularSeries())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockLocalDataSource.getCachedPopularSeries());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });

  group('Top Rated Series', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => []);
      // act
      await repository.getTopRatedSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            final result = await repository.getTopRatedSeries();
            // assert
            verify(mockRemoteDataSource.getTopRatedSeries());
            /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
            final resultList = result.getOrElse(() => []);
            expect(resultList, tSeriesList);
          });

      test(
          'should cache data locally when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedSeries())
                .thenAnswer((_) async => tSeriesModelList);
            // act
            await repository.getTopRatedSeries();
            // assert
            verify(mockRemoteDataSource.getTopRatedSeries());
            verify(mockLocalDataSource.cacheToTopRatedSeries([testMovieTable]));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDataSource.getTopRatedSeries())
                .thenThrow(ServerException());
            // act
            final result = await repository.getTopRatedSeries();
            // assert
            verify(mockRemoteDataSource.getTopRatedSeries());
            expect(result, equals(Left(ServerFailure(''))));
          });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedSeries())
            .thenAnswer((_) async => [testSeriesTable]);
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return DatabaseFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedSeries())
            .thenThrow(DatabaseFailure('No Cache'));
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedSeries());
        expect(result, Left(DatabaseFailure('No Cache')));
      });
    });
  });
}