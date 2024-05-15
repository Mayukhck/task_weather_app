import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/src/features/weather/domain/weather_data.dart';
import 'package:task_weather_app/src/features/weather/provider/weather_provider.dart';
import 'package:task_weather_app/src/features/weather/repository/weather_repository.dart';

import '../presentation/home_view_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  group('WeatherProvider tests', () {
    test('successful weather data fetch', () async {
      final MockWeatherRepository mockWeatherRepository =
          MockWeatherRepository();

      const cityName = 'Berlin';

      final expectedWeatherData = WeatherModel(temperature: 19);

      when(mockWeatherRepository.fetchWeatherData(cityName, any))
          .thenAnswer((_) async => expectedWeatherData);

      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      final notifier = container.read(weatherStateNotifierProvider.notifier);

      await notifier.fetchWeather(cityName);

      final weatherState = container.read(weatherStateNotifierProvider);

      expect(weatherState, AsyncData(expectedWeatherData));
    });

    test('fetch weather with network error throws exception', () async {
      final mockWeatherRepository = MockWeatherRepository();

      when(mockWeatherRepository.fetchWeatherData(any, any))
          .thenThrow(Exception('Network error'));

      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      final notifier = container.read(weatherStateNotifierProvider.notifier);

      await notifier.fetchWeather('Berlin');

      final weatherState = container.read(weatherStateNotifierProvider);

      expect(weatherState, isA<AsyncError>());
      expect((weatherState as AsyncError).error, isException);
    });
  });
}
