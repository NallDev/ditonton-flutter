
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:flutter/foundation.dart';

class NowPlayingSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingSeries getNowPlayingSeries;

  NowPlayingSeriesNotifier(this.getNowPlayingSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
