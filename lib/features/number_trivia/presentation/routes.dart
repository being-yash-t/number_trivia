import 'package:get/get.dart';
import 'package:ntrivia/features/number_trivia/presentation/controllers/number_trivia_controller.dart';
import 'package:ntrivia/features/number_trivia/presentation/pages/home_page.dart';

class NumberTriviaRoutes {
  static const homeRoute = "/home";
}

List numberTriviaPages = [
  GetPage(
    name: NumberTriviaRoutes.homeRoute,
    page: () => HomePage(),
    binding: BindingsBuilder.put(() => NumberTriviaController()),
  ),
];
