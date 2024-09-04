import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedSeries(mockMovieRepository);
  });

  final tSeries = <Movie>[];

  test('should get list of series from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
