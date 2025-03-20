import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTime checkIfUserIsFirstTime,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTime = checkIfUserIsFirstTime,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTime _checkIfUserIsFirstTime;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(failure.message)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTime() async {
    emit(const CheckingIfUserIsFirstTime());

    final result = await _checkIfUserIsFirstTime();

    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTime: true)),
      (status) => emit(OnBoardingStatus(isFirstTime: status)),
    );
  }
}
