import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ntrivia/features/number_trivia/presentation/routes.dart';

void main() {}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Number Trivia",
      getPages: [
        ...numberTriviaPages,
      ],
      initialRoute: NumberTriviaRoutes.homeRoute,
    );
  }
}
