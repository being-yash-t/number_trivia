import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/core/util/input_converter.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaController extends GetxController {
  final Rx<NumberTrivia?> currentNumberTrivia = Rx<NumberTrivia?>(null);
  final Rx<String?> currentError = Rx<String?>(null);
  bool get hasError => currentError() != null;
  final RxBool isLoading = RxBool(false);

  void getTriviaForConcreteNumber(String numberData) {
    isLoading(true);
    final parsedInt = parseStringToInt(numberData);
    isLoading(false);
  }

  void getTriviaForRandomNumber() {
    isLoading(true);
    isLoading(false);
  }

  Either<BasicFailure, int> parseStringToInt(String str) =>
    InputConverter.stringToUnsignedInt(str);

}
