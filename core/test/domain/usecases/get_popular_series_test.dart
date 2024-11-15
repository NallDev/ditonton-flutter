import 'package:core/domain/usecases/get_popular_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockMoviesRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMoviesRepository();
    usecase = GetPopularSeries(mockMovieRpository);
  });

  final tSeries = <Movie>[];

  group('GetPopularSeries Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getPopularSeries())
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSeries));
      });
    });
  });
}
