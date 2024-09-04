import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/presentation/provider/popular_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetPopularSeries();
    notifier = PopularSeriesNotifier(mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(tSeriesData));
    // act
    notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(tSeriesData));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tSeriesData);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
