part of 'on_boarding_cubit.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

final class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

final class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

final class CheckingIfUserIsFirstTime extends OnBoardingState {
  const CheckingIfUserIsFirstTime();
}

final class UserCached extends OnBoardingState {
  const UserCached();
}

final class OnBoardingStatus extends OnBoardingState {
  const OnBoardingStatus({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<Object> get props => [isFirstTimer];
}

final class OnBoardingError extends OnBoardingState {
  const OnBoardingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
