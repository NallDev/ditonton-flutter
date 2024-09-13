import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_popular_series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;

  PopularSeriesBloc({
    required this.getPopularSeries,
  }) : super(PopularSeriesLoading()) {

    on<FetchPopularSeries>((event, emit) async {
      emit(PopularSeriesLoading());
      final result = await getPopularSeries.execute();
      result.fold(
            (failure) => emit(PopularSeriesError(failure.message)),
            (series) => emit(PopularSeriesHasData(series)),
      );
    });
  }
}