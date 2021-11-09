import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late final GetConcreteNumberTrivia useCase;
  late final MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: "$tNumber test", number: tNumber);

  test('should get trivia for the number from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getFromNumber(any))
        .thenAnswer((_) => Future.value(const Right(tNumberTrivia)));

    // act
    final result = await useCase(number: tNumber);

    // assert & verify
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getFromNumber(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
