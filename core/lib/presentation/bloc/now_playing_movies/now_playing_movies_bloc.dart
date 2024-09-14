import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_state.dart';
part 'now_playing_movies_event.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesLoading()) {

    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
            (failure) => emit(NowPlayingMoviesError(failure.message)),
            (movies) => emit(NowPlayingMoviesHasData(movies)),
      );
    });
  }
}