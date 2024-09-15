part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends DetailEvent {
  final int id;

  FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchSeriesDetail extends DetailEvent {
  final int id;

  FetchSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}
