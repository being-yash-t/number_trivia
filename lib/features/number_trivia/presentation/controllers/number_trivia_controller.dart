import 'package:get/get.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaController extends GetxController {
  final Rx<NumberTrivia?> currentNumberTrivia = Rx<NumberTrivia?>(null);
  final Rx<String?> currentFailure = Rx<String?>(null);
  bool get hasError => currentFailure() != null;
  final RxBool isLoading = RxBool(false);

  void getTriviaForConcreteNumber(String numberData) {
    isLoading(true);
    isLoading(false);
  }

  void getTriviaForRandomNumber() {
    isLoading(true);
    isLoading(false);
  }
}
