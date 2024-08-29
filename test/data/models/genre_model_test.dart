import 'dart:convert';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: 'Action',
  );

  final tGenre = Genre(
    id: 1,
    name: 'Action',
  );

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/genre.json'));
      // act
      final result = GenreModel.fromJson(jsonMap);
      // assert
      expect(result, tGenreModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Action",
      };

      expect(result, expectedJsonMap);
    });
  });
}
