import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_state.dart';
part 'watchlist_event.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistBloc(this._getWatchlistMovies) : super(WatchlistEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {

      emit(WatchlistLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
            (failure) {
              emit(WatchlistError(failure.message));
            },
            (moviesData) {
              emit(WatchlistHasData(moviesData));
            },
      );
    });
  }
}