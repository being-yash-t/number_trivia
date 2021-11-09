import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const NumberTriviaModel tNumberTriviaModel =
      NumberTriviaModel(number: 1, text: "test text");

  test('should be a sub-class of NumberTrivia entity', () {
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return valid model when the json number is int', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert & verify
      expect(result, tNumberTriviaModel);
    });
  });

  group('fromJson', () {
    test('should return valid model when the json number is double', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert & verify
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      // arrange
      // act
      final result = tNumberTriviaModel.toJson();
      // assert & verify
      final expectedMap = {
        "text": "test text",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
