import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/core/util/input_converter.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:ntrivia/features/number_trivia/presentation/controllers/number_trivia_controller.dart';

import 'number_trivia_controller_test.mocks.dart';

@GenerateMocks([GetRandomNumberTrivia, GetConcreteNumberTrivia])
void main() {
  late NumberTriviaController numberTriviaController;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  setUp(() {
    numberTriviaController = NumberTriviaController();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
  });

  test("initial State should be empty", () async {
    expect(numberTriviaController.isLoading(), false);
    expect(numberTriviaController.hasError, false);
    expect(numberTriviaController.currentNumberTrivia(), null);
  });

  // group('GerTriviaForConcreteNumber', () {
  //   const tNumberString = '1';
  //   const tNumberParsed = 1;
  //   const tNumberTrivia = NumberTrivia(text: "test text", number: 1);
  //
  //   test(
  //       'should call inputConverter to validate & convert the string to an unsigned int',
  //       () async {
  //     //arrange
  //
  //     // act
  //     final res numberTriviaController.getTriviaForConcreteNumber(tNumberString);
  //     // assert
  //     expect(numberTriviaController.parseStringToInt(tNumberString));
  //   });
  // });
}
