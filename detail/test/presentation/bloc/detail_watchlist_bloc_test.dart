import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:detail/presentation/bloc/detail_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DetailWatchlistBloc watchlistBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    watchlistBloc = DetailWatchlistBloc(
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  const tSuccessMessage = 'Added to Watchlist';
  const tRemoveMessage = 'Removed from Watchlist';

  group('AddToWatchlist', () {
    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [AddToWatchlistSuccess, WatchlistStatus] when adding to watchlist is successful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right(tSuccessMessage));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      expect: () => [
        AddToWatchlistSuccess(tSuccessMessage),
        WatchlistStatus(true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [AddToWatchlistError] when adding to watchlist is unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to add')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      expect: () => [
        AddToWatchlistError('Failed to add'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });

  group('RemoveFromWatchlist', () {
    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [AddToWatchlistSuccess, WatchlistStatus] when removing from watchlist is successful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right(tRemoveMessage));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        AddToWatchlistSuccess(tRemoveMessage),
        WatchlistStatus(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [AddToWatchlistError] when removing from watchlist is unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        AddToWatchlistError('Failed to remove'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });

  group('FetchWatchlistStatus', () {
    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [WatchlistStatus] when fetching watchlist status is successful',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
      expect: () => [
        WatchlistStatus(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<DetailWatchlistBloc, WatchlistState>(
      'Should emit [WatchlistStatus] when fetching watchlist status returns false',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
      expect: () => [
        WatchlistStatus(false),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}