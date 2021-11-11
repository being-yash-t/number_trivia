import 'package:dartz/dartz.dart';
import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/core/platform/network_info.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ntrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<BasicFailure, NumberTrivia>> getFromNumber(int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getFromNumber(number);
    });
  }

  @override
  Future<Either<BasicFailure, NumberTrivia>> getRandom() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandom();
    });
  }

  Future<Either<BasicFailure, NumberTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteTrivia = await localDataSource.getLastNumberTrivia();
        return Right(remoteTrivia);
      } on CachedException {
        return Left(CacheFailure());
      }
    }
  }
}
