import 'package:education_app/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:education_app/src/on_boarding/presentaion/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  // Business Logic
  getIt
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: getIt(),
        checkIfUserIsFirstTimer: getIt(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(repository: getIt()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTime(repository: getIt()))
    ..registerFactory<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(dataSource: getIt()),
    )
    ..registerFactory<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(preferences: prefs),
    );
}
