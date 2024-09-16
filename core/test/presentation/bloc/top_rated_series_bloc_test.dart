import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedSeriesBloc topRatedSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBloc = TopRatedSeriesBloc(getTopRatedSeries: mockGetTopRatedSeries);
  });

  group('FetchTopRatedSeries', () {
    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'Should emit [TopRatedSeriesLoading, TopRatedSeriesHasData] when data is fetched successfully',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeries()),
      expect: () => [
        TopRatedSeriesLoading(),
        TopRatedSeriesHasData(testSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'Should emit [TopRatedSeriesLoading, TopRatedSeriesError] when fetching data is unsuccessful',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed to fetch data')));
        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeries()),
      expect: () => [
        TopRatedSeriesLoading(),
        TopRatedSeriesError('Failed to fetch data'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });
}