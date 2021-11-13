import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntrivia/core/util/input_converter.dart';

void main() {
  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        // arrange
        const str = '123';
        // act
        final result = InputConverter.stringToUnsignedInt(str);
        // assert
        expect(result, const Right(123));
      },
    );
    test(
      'should return an failure when the string is not an integer',
      () async {
        // arrange
        const str = 'abc';
        // act
        final result = InputConverter.stringToUnsignedInt(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
    test(
      'should return an failure when the string is a negative integer',
      () async {
        // arrange
        const str = '-123';
        // act
        final result = InputConverter.stringToUnsignedInt(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
