import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:detail/presentation/bloc/detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    detailBloc = DetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getSeriesDetail: mockGetSeriesDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getSeriesRecommendations: mockGetSeriesRecommendations,
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    isSeries: false,
  );
  final tMovies = <Movie>[tMovie];

  final tSeries = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: '2024-08-01',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    isSeries: true,
  );
  final tSeriesData = <Movie>[tSeries];

  group('FetchMovieDetail', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailHasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return detailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        DetailLoading(),
        DetailHasData(movie: testMovieDetail, recommendations: tMovies),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailError] when getting movie recommendations is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('FetchSeriesDetail', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailHasData] when series data is gotten successfully',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tSeriesData));
        return detailBloc;
      },
      act: (bloc) => bloc.add(FetchSeriesDetail(tId)),
      expect: () => [
        DetailLoading(),
        DetailHasData(movie: testSeriesDetail, recommendations: tSeriesData),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
        verify(mockGetSeriesRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailError] when getting series recommendations is unsuccessful',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(FetchSeriesDetail(tId)),
      expect: () => [
        DetailLoading(),
        DetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
        verify(mockGetSeriesRecommendations.execute(tId));
      },
    );
  });
}