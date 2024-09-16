import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:detail/domain/usecases/get_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockDetailRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockDetailRepository();
    usecase = GetSeriesRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tSeries = <Movie>[];

  test('should get list of series recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
