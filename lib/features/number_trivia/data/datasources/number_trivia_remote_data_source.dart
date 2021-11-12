import 'dart:convert';

import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  // Gets the data from remote source
  // Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getFromNumber(int number);
  // Gets the data from remote source
  // Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandom();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getFromNumber(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandom() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final uri = Uri.parse(url);
    final res = await client.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (res.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }
}
