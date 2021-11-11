import 'package:equatable/equatable.dart';

abstract class BasicFailure extends Equatable {
}

class ServerFailure extends BasicFailure  {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends BasicFailure {
  @override
  List<Object?> get props => [];

}