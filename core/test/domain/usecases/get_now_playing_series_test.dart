import 'package:core/domain/usecases/get_now_playing_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingSeries usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetNowPlayingSeries(mockMovieRepository);
  });

  final tSeries = <Movie>[];

  test('should get list of series from the repository', () async {
    // arrange
    when(mockMovieRepository.getNowPlayingSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
