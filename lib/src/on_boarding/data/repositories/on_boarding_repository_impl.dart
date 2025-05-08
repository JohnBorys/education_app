import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  const OnBoardingRepositoryImpl({
    required OnBoardingLocalDataSource dataSource,
  }) : _dataSource = dataSource;

  final OnBoardingLocalDataSource _dataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _dataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _dataSource.checkIfUserIsFirstTime();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
