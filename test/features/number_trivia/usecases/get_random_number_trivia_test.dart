import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/core/usecases/no_params.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late final GetRandomNumberTrivia useCase;
  late final MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(text: "1 test", number: 1);

  test('should get random trivia from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getRandom())
        .thenAnswer((_) => Future.value(const Right(tNumberTrivia)));

    // act
    final result = await useCase(NoParams());

    // assert & verify
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandom());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}