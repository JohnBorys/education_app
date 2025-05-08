import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTime extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTime({required OnBoardingRepository repository})
      : _repository = repository;

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.checkIfUserIsFirstTimer();
}
