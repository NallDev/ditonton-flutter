part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {}

class DetailHasData extends DetailState {
  final MovieDetail movie;
  final List<Movie> recommendations;

  DetailHasData({required this.movie, required this.recommendations,});

  @override
  List<Object?> get props => [movie, recommendations];
}

class DetailError extends DetailState {
  final String message;

 DetailError(this.message);

  @override
  List<Object?> get props => [message];
}
