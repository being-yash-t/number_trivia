import 'package:dartz/dartz.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<BasicFailure, NumberTrivia>> getFromNumber(int number);
  Future<Either<BasicFailure, NumberTrivia>> getRandom();
}
