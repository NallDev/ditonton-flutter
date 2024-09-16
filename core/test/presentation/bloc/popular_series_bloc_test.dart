import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularSeriesBloc popularSeriesBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(getPopularSeries: mockGetPopularSeries);
  });

  group('FetchPopularSeries', () {
    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'Should emit [PopularSeriesLoading, PopularSeriesHasData] when data is fetched successfully',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeries()),
      expect: () => [
        PopularSeriesLoading(),
        PopularSeriesHasData(testSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'Should emit [PopularSeriesLoading, PopularSeriesError] when fetching data is unsuccessful',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed to fetch data')));
        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeries()),
      expect: () => [
        PopularSeriesLoading(),
        PopularSeriesError('Failed to fetch data'),
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });
}