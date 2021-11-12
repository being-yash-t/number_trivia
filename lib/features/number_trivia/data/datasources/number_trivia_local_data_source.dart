import 'dart:convert';

import 'package:ntrivia/core/constants.dart';
import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  // Gets [NumberTrivia] which was gotten the last time user had connection
  // Throws [CacheException] if no cache data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  // Save [NumberTrivia] to device cache
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      cachedNumberTriviaKey,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTriviaKey);
    if (jsonString == null) {
      throw CachedException();
    } else {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }
  }
}
