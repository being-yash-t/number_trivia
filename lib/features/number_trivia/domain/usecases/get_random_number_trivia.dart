import 'package:dartz/dartz.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/core/usecases/no_params.dart';
import 'package:ntrivia/core/usecases/usecase.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<BasicFailure, NumberTrivia>> call(NoParams _) =>
      repository.getRandom();
}
