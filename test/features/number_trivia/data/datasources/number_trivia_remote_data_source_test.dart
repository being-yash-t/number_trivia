import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setupMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setupMockHttpClientFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response("Not Found", 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(text: "test text", number: 1);
    test(
        'should perform GET request on a url with number being the endpoint'
        ' and with application/json header', () {
      // arrange
      setupMockHttpClientSuccess();
      // act
      dataSource.getFromNumber(tNumber);
      // assert
      final uri = Uri.parse('http://numbersapi.com/$tNumber');
      verify(mockHttpClient.get(uri, headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('should return NumberTrivia when response code is 200', () async {
      // arrange
      setupMockHttpClientSuccess();
      // act
      final res = await dataSource.getFromNumber(tNumber);
      // assert
      expect(res, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      // arrange
      setupMockHttpClientFailure();
      // act
      final call = dataSource.getFromNumber;
      // assert
      expect(
        () => call(tNumber),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: "test text", number: 1);
    test(
        'should perform GET request on a url with number being the endpoint'
        ' and with application/json header', () {
      // arrange
      setupMockHttpClientSuccess();
      // act
      dataSource.getRandom();
      // assert
      final uri = Uri.parse('http://numbersapi.com/random');
      verify(mockHttpClient.get(uri, headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('should return NumberTrivia when response code is 200', () async {
      // arrange
      setupMockHttpClientSuccess();
      // act
      final res = await dataSource.getRandom();
      // assert
      expect(res, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      // arrange
      setupMockHttpClientFailure();
      // act
      final call = dataSource.getRandom;
      // assert
      expect(
        () => call(),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
