import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(getNowPlayingSeries: mockGetNowPlayingSeries);
  });

  group('FetchNowPlayingSeries', () {
    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'Should emit [NowPlayingSeriesLoading, NowPlayingSeriesHasData] when data is fetched successfully',
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Right(testSeriesList));
        return nowPlayingSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSeries()),
      expect: () => [
        NowPlayingSeriesLoading(),
        NowPlayingSeriesHasData(testSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'Should emit [NowPlayingSeriesLoading, NowPlayingSeriesError] when fetching data is unsuccessful',
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed to fetch data')));
        return nowPlayingSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSeries()),
      expect: () => [
        NowPlayingSeriesLoading(),
        NowPlayingSeriesError('Failed to fetch data'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );
  });
}
