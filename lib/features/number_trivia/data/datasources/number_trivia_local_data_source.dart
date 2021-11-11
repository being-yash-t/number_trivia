import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  // Gets [NumberTrivia] which was gotten the last time user had connection
  // Throws [CacheException] if no cache data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  // Save [NumberTrivia] to device cache
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}