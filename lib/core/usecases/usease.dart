import 'package:dartz/dartz.dart';
import 'package:ntrivia/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<BasicFailure, Type>> call(Params params);
}