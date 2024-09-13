import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_now_playing_series.dart';

part 'now_playing_series_event.dart';
part 'now_playing_series_state.dart';

class NowPlayingSeriesBloc extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries getNowPlayingSeries;

  NowPlayingSeriesBloc({
    required this.getNowPlayingSeries,
  }) : super(NowPlayingSeriesLoading()) {

    on<FetchNowPlayingSeries>((event, emit) async {
      emit(NowPlayingSeriesLoading());
      final result = await getNowPlayingSeries.execute();
      result.fold(
            (failure) => emit(NowPlayingSeriesError(failure.message)),
            (series) => emit(NowPlayingSeriesHasData(series)),
      );
    });
  }
}