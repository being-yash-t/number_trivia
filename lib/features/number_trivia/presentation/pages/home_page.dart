import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ntrivia/features/number_trivia/presentation/controllers/number_trivia_controller.dart';
import 'package:ntrivia/features/number_trivia/presentation/widgets/display_text_view.dart';

class HomePage extends GetView<NumberTriviaController> {
  final TextEditingController concreteNumberController =
      TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NumberTrivia")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 250,
              child: Obx(() {
                if (controller.isLoading()) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.hasError) {
                  return Center(child: Text(controller.currentError()!));
                } else if (controller.hasData) {
                  final data = controller.currentNumberTrivia()!;
                  return DisplayTextView(value: data.text);
                } else {
                  return const DisplayTextView(value: "Hola!");
                }
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: concreteNumberController,
              inputFormatters: <TextInputFormatter>[
                // Only numbers can be entered
                FilteringTextInputFormatter.digitsOnly
              ],
              onSubmitted: controller.getTriviaForConcreteNumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Feeling lucky, but number"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _getForConcrete,
                      child: const Text("Concrete"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: controller.getTriviaForRandomNumber,
                      child: const Text("Random"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getForConcrete() {
    final args = concreteNumberController.text;
    controller.getTriviaForConcreteNumber(args);
  }
}
