import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_series_detail.dart';
import '../../domain/usecases/get_series_recommendations.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail getMovieDetail;
  final GetSeriesDetail getSeriesDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetSeriesRecommendations getSeriesRecommendations;

  DetailBloc({
    required this.getMovieDetail,
    required this.getSeriesDetail,
    required this.getMovieRecommendations,
    required this.getSeriesRecommendations,
  }) : super(DetailLoading()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult = await getMovieRecommendations.execute(event.id);

      detailResult.fold(
            (failure) {
          emit(DetailError(failure.message));
        },
            (movie) async {
          recommendationResult.fold(
                (failure) {
              emit(DetailError(failure.message));
            },
                (movies) {
              emit(DetailHasData(movie: movie, recommendations: movies));
            },
          );
        },
      );
    });

    on<FetchSeriesDetail>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await getSeriesDetail.execute(event.id);
      final recommendationResult = await getSeriesRecommendations.execute(event.id);

      detailResult.fold(
            (failure) {
          emit(DetailError(failure.message));
        },
            (movie) async {
          recommendationResult.fold(
                (failure) {
              emit(DetailError(failure.message));
            },
                (series) {
              emit(DetailHasData(movie: movie, recommendations: series));
            },
          );
        },
      );
    });
  }
}