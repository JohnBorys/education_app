import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource dataSource;
  late OnBoardingRepositoryImpl repositoryImpl;

  setUp(() {
    dataSource = MockOnBoardingLocalDataSource();
    repositoryImpl = OnBoardingRepositoryImpl(dataSource: dataSource);
  });

  test('should  be a subclass of [OnBoardingRepository]', () {
    expect(repositoryImpl, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test('should complete successfully when call to local source is successful',
        () async {
      when(() => dataSource.cacheFirstTimer())
          .thenAnswer((_) async => const Right<dynamic, void>(null));

      final result = await repositoryImpl.cacheFirstTimer();

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return [CacheFailure] when call to local sourse is '
        'unsuccessful', () async {
      when(() => dataSource.cacheFirstTimer()).thenThrow(
        const CacheException(message: 'Insufficient storage'),
      );

      final result = await repositoryImpl.cacheFirstTimer();

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        ),
      );

      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('checkIfUserIsFirstTime', () {
    test('should complete successfully when call to local source is successful',
        () async {
      when(() => dataSource.checkIfUserIsFirstTime())
          .thenAnswer((_) async => true);

      final result = await repositoryImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(() => dataSource.checkIfUserIsFirstTime()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return [CacheFailure] when call to local sourse is '
        'unsuccessful', () async {
      when(() => dataSource.checkIfUserIsFirstTime()).thenThrow(
        const CacheException(message: 'Insufficient storage'),
      );

      final result = await repositoryImpl.checkIfUserIsFirstTimer();

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        ),
      );

      verify(() => dataSource.checkIfUserIsFirstTime()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
