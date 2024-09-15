part of 'detail_watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  AddToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  RemoveFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchWatchlistStatus extends WatchlistEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
