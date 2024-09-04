import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
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

  final tCombineList = [...tSeriesList, ...tMovieList];

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

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieDetail(tId))
              .thenAnswer((_) async => tMovieResponse);
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
          expect(result, equals(Right(testMovieDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenAnswer((_) async => tMovieList);
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tMovieList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
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

  group('Get Series Detail', () {
    final tId = 1;
    final tSeriesResponse = SeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [
        GenreModel(id: 1, name: 'Action'),
      ],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: '2024-08-01',
      title: 'title',
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeriesDetail(tId))
              .thenAnswer((_) async => tSeriesResponse);
          // act
          final result = await repository.getSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getSeriesDetail(tId));
          expect(result, equals(Right(testSeriesDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeriesDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getSeriesDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeriesDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getSeriesDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Series Recommendations', () {
    final tSeriesList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenAnswer((_) async => tSeriesList);
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tSeriesList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchMovies(tQuery))
              .thenAnswer((_) async => tMovieModelList);
          when(mockRemoteDataSource.searchSeries(tQuery))
              .thenAnswer((_) async => tSeriesModelList);

          // act
          final result = await repository.searchMovies(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tCombineList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchMovies(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchMovies(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchMovies(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchMovies(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}