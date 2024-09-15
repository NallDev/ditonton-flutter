import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class DetailWatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  DetailWatchlistBloc(
      {required this.saveWatchlist, required this.removeWatchlist, required this.getWatchListStatus}) : super(InitialState()) {

    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(AddToWatchlistError(failure.message));
        },
        (successMessage) {
          emit(AddToWatchlistSuccess(successMessage));
          add(FetchWatchlistStatus(event.movie.id));
        },
      );
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(AddToWatchlistError(failure.message));
        },
        (successMessage) {
          emit(AddToWatchlistSuccess(successMessage));
          add(FetchWatchlistStatus(event.movie.id));
        },
      );
    });

    on<FetchWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistStatus(result));
    });
  }
}
