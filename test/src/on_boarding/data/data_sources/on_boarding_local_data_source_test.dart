import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences preferences;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    preferences = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(preferences: preferences);
  });

  group('cachFirstTimer', () {
    test('shoult call [SharedPreferences] to cache the data', () async {
      when(() => preferences.setBool(any(), any()))
          .thenAnswer((_) async => true);

      await localDataSource.cacheFirstTimer();

      verify(
        () => preferences.setBool(kFirstTimerKey, false),
      ).called(1);

      verifyNoMoreInteractions(preferences);
    });
  });

  test('should throw a [CachException] when there is an error caching the data',
      () async {
    when(() => preferences.setBool(any(), any())).thenThrow(Exception());

    final methodCall = localDataSource.cacheFirstTimer;

    expect(methodCall, throwsA(isA<CacheException>()));

    verify(() => preferences.setBool(kFirstTimerKey, false));

    verifyNoMoreInteractions(preferences);
  });

  group('checkIfUserIsFirstTime', () {
    test(
        'shoult call [SharedPreferences] to check if user is first timer and '
        'return the rigth response  when storage data exist', () async {
      when(() => preferences.getBool(any())).thenReturn(false);

      final result = await localDataSource.checkIfUserIsFirstTime();

      expect(result, false);

      verify(
        () => preferences.getBool(kFirstTimerKey),
      ).called(1);

      verifyNoMoreInteractions(preferences);
    });
  });

  test('should return true if there is no data in storage', () async {
    when(() => preferences.getBool(any())).thenReturn(null);

    final result = await localDataSource.checkIfUserIsFirstTime();

    expect(result, true);

    verify(
      () => preferences.getBool(kFirstTimerKey),
    ).called(1);

    verifyNoMoreInteractions(preferences);
  });

  test(
      'should throw a [CachException] when there is an error '
      'retrieving the data', () async {
    when(() => preferences.getBool(any())).thenThrow(Exception());

    final methodCall = localDataSource.checkIfUserIsFirstTime();

    expect(methodCall, throwsA(isA<CacheException>()));

    verify(() => preferences.getBool(kFirstTimerKey)).called(1);

    verifyNoMoreInteractions(preferences);
  });
}
