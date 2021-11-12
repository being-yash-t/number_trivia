import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ntrivia/core/error/exceptions.dart';
import 'package:ntrivia/core/error/failures.dart';
import 'package:ntrivia/core/network/network_info.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:ntrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ntrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:ntrivia/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockNumberTriviaRemoteDataSource mockRemoteDS;
  late MockNumberTriviaLocalDataSource mockLocalDS;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDS = MockNumberTriviaLocalDataSource();
    mockRemoteDS = MockNumberTriviaRemoteDataSource();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDS,
      localDataSource: mockLocalDS,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel =
        NumberTriviaModel(text: "$tNumber text", number: tNumber);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    // test('should check if device is online', () async {
    //   // arrange
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   // act
    //   repositoryImpl.getFromNumber(tNumber);
    //   // assert & verify
    //   verify(mockNetworkInfo.isConnected);
    // });

    runTestsOnline(() {
      test('should return remote data when call to remote data is successful',
          () async {
        // arrange
        when(mockRemoteDS.getFromNumber(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final res = await repositoryImpl.getFromNumber(tNumber);
        // assert & verify
        verify(mockRemoteDS.getFromNumber(tNumber));
        expect(res, equals(const Right(tNumberTrivia)));
      });

      test('should cache data locally when call to remote data is successful',
          () async {
        // arrange
        when(mockRemoteDS.getFromNumber(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        await repositoryImpl.getFromNumber(tNumber);
        // assert & verify
        verify(mockRemoteDS.getFromNumber(tNumber));
        verify(mockLocalDS.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure when call to remote data is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDS.getFromNumber(any)).thenThrow(ServerException());
        // act
        final res = await repositoryImpl.getFromNumber(tNumber);
        // assert & verify
        verify(mockRemoteDS.getFromNumber(tNumber));
        verifyZeroInteractions(mockLocalDS);
        expect(res, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when cached data is preset',
          () async {
        // arrange
        when(mockLocalDS.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final res = await repositoryImpl.getFromNumber(tNumber);
        // assert & verify
        verifyZeroInteractions(mockRemoteDS);
        verify(mockLocalDS.getLastNumberTrivia());
        expect(res, equals(const Right(tNumberTrivia)));
      });

      test(
          'should return cache failure when call to local data is unsuccessful',
          () async {
        // arrange
        when(mockLocalDS.getLastNumberTrivia()).thenThrow(CachedException());
        // act
        final res = await repositoryImpl.getFromNumber(tNumber);
        // assert & verify
        verifyZeroInteractions(mockRemoteDS);
        verify(mockLocalDS.getLastNumberTrivia());
        expect(res, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: "1 text", number: 1);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    // test('should check if device is online', () async {
    //   // arrange
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   // act
    //   repositoryImpl.getFromNumber(tNumber);
    //   // assert & verify
    //   verify(mockNetworkInfo.isConnected);
    // });

    runTestsOnline(() {
      test('should return remote data when call to remote data is successful',
          () async {
        // arrange
        when(mockRemoteDS.getRandom())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final res = await repositoryImpl.getRandom();
        // assert & verify
        verify(mockRemoteDS.getRandom());
        expect(res, equals(const Right(tNumberTrivia)));
      });

      test('should cache data locally when call to remote data is successful',
          () async {
        // arrange
        when(mockRemoteDS.getRandom())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        await repositoryImpl.getRandom();
        // assert & verify
        verify(mockRemoteDS.getRandom());
        verify(mockLocalDS.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure when call to remote data is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDS.getRandom()).thenThrow(ServerException());
        // act
        final res = await repositoryImpl.getRandom();
        // assert & verify
        verify(mockRemoteDS.getRandom());
        verifyZeroInteractions(mockLocalDS);
        expect(res, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when cached data is preset',
          () async {
        // arrange
        when(mockLocalDS.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final res = await repositoryImpl.getRandom();
        // assert & verify
        verifyZeroInteractions(mockRemoteDS);
        verify(mockLocalDS.getLastNumberTrivia());
        expect(res, equals(const Right(tNumberTrivia)));
      });

      test(
          'should return cache failure when call to local data is unsuccessful',
          () async {
        // arrange
        when(mockLocalDS.getLastNumberTrivia()).thenThrow(CachedException());
        // act
        final res = await repositoryImpl.getRandom();
        // assert & verify
        verifyZeroInteractions(mockRemoteDS);
        verify(mockLocalDS.getLastNumberTrivia());
        expect(res, equals(Left(CacheFailure())));
      });
    });
  });
}
