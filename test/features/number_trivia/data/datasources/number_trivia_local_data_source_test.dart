import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/core/constants.dart';
import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLocalDataSourceImpl dataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should return numberTrivia from sharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));
      // act
      final res = await dataSourceImpl.getLastNumberTrivia();
      // assert & verify
      verify(mockSharedPreferences.getString(cachedNumberTriviaKey));
      expect(res, equals(tNumberTriviaModel));
    });

    test('should throw cacheException when there is no data in cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSourceImpl.getLastNumberTrivia;
      // assert & verify
      expect(() => call(), throwsA(const TypeMatcher<CachedException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: "test text", number: 1);
    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) => Future.value(true));
      // act
      dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(
        mockSharedPreferences.setString(
            cachedNumberTriviaKey, expectedJsonString),
      );
    });
  });
}
