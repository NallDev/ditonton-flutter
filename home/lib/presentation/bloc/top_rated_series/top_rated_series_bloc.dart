import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesBloc({
    required this.getTopRatedSeries,
  }) : super(TopRatedSeriesLoading()) {

    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedSeriesLoading());
      final result = await getTopRatedSeries.execute();
      result.fold(
            (failure) => emit(TopRatedSeriesError(failure.message)),
            (series) => emit(TopRatedSeriesHasData(series)),
      );
    });
  }
}