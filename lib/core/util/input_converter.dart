import 'package:dartz/dartz.dart';
import 'package:ntrivia/core/error/failures.dart';

class InputConverter {
  static Either<BasicFailure, int> stringToUnsignedInt(String str) {
    try {
      final value = int.parse(str);
      if (value < 0) throw const FormatException("Integer is negative");
      return Right(value);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends BasicFailure {
  @override
  List<Object?> get props => [];
}
