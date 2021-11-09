import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) =>
      NumberTriviaModel(
        text: jsonMap['text'],
        number: (jsonMap['number'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "number": number,
      };
}
