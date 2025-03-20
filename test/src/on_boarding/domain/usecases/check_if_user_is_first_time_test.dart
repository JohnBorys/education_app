import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:education_app/src/on_boarding/repositories/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/on_boarding_repository_mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CheckIfUserIsFirstTime usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CheckIfUserIsFirstTime(repository: repository);
  });

  test(
      'should call the [OnBoardingRepository.checkIfUserIsFirstTime] '
      'and return the right data', () async {
    when(() => repository.checkIfUserIsFirstTime())
        .thenAnswer((_) async => const Right(true));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, bool>(true)));

    verify(() => repository.checkIfUserIsFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
    'should call the [OnBoardingRepository.checkIfUserIsFirstTime] '
    'and return the right data',
    () async {
      when(() => repository.checkIfUserIsFirstTime()).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error Occurred',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => repository.checkIfUserIsFirstTime()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
