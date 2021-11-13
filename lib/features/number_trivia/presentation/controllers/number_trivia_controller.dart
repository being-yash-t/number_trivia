import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/core/usecases/no_params.dart';
import 'package:ntrivia/core/util/input_converter.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class NumberTriviaController extends GetxController {
  final Rx<NumberTrivia?> currentNumberTrivia = Rx<NumberTrivia?>(null);
  final Rx<String?> currentError = Rx<String?>(null);
  final RxBool isLoading = RxBool(false);

  late final GetConcreteNumberTrivia getConcreteNumberTrivia;
  late final GetRandomNumberTrivia getRandomNumberTrivia;

  bool get hasError => currentError() != null;
  bool get hasData => currentNumberTrivia() != null;

  NumberTriviaController() {
    final repository = Get.find<NumberTriviaRepository>();
    getConcreteNumberTrivia = GetConcreteNumberTrivia(repository);
    getRandomNumberTrivia = GetRandomNumberTrivia(repository);
  }

  void getTriviaForConcreteNumber(String numberData) async {
    isLoading(true);
    final parseResult = parseStringToInt(numberData);
    await parseResult.fold<Future>(
      (failure) async {
        currentError(failure.runtimeType.toString());
        currentNumberTrivia.value = null;
      },
      (parsedInt) async {
        final res = await getConcreteNumberTrivia(Params(number: parsedInt));
        res.fold(
          (failure) {
            currentError(failure.runtimeType.toString());
            currentNumberTrivia.value = null;
          },
          (NumberTrivia numberTrivia) {
            currentNumberTrivia(numberTrivia);
            currentError.value = null;
          },
        );
      },
    );

    isLoading(false);
  }

  void getTriviaForRandomNumber() async {
    isLoading(true);
    final res = await getRandomNumberTrivia(NoParams());
    res.fold(
      (failure) {
        currentError(failure.runtimeType.toString());
        currentNumberTrivia.value = null;
      },
      (NumberTrivia numberTrivia) {
        currentNumberTrivia(numberTrivia);
        currentError.value = null;
      },
    );
    isLoading(false);
  }

  Either<BasicFailure, int> parseStringToInt(String str) =>
      InputConverter.stringToUnsignedInt(str);
}
