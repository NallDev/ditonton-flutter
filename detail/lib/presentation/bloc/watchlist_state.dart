part of 'detail_watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class InitialState extends WatchlistState{}

class WatchlistStatus extends WatchlistState {
  final bool isAddedToWatchlist;

  WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}


class AddToWatchlistSuccess extends WatchlistState {
  final String message;

  AddToWatchlistSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AddToWatchlistError extends WatchlistState {
  final String message;

  AddToWatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}