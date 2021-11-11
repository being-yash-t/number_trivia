import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  // Gets the data from remote source
  // Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getFromNumber(int number);
  // Gets the data from remote source
  // Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandom();
}
