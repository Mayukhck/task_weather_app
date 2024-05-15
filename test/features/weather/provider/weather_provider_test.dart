import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/features/weather/domain/weather_data.dart';
import 'package:task_weather_app/features/weather/provider/weather_provider.dart';
import 'package:task_weather_app/features/weather/repository/weather_repository.dart';

import '../presentation/home_view_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  group('WeatherProvider tests', () {
    test(' successful weather data fetch', () async {
      final MockWeatherRepository mockWeatherRepository =
          MockWeatherRepository();

      const cityName = 'Berline';

      final expectedWeatherData = WeatherModel(temperature: 19);

      when(mockWeatherRepository.fetchWeatherData('Berline', any))
          .thenAnswer((_) async => expectedWeatherData);

      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      final weatherData =
          await container.read(weatherFutureProvider(cityName).future);

      expect(weatherData, expectedWeatherData);
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

      final future = container.read(weatherFutureProvider('Berlin').future);

      expect(future, throwsException);
    });
  });
}
