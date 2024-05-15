import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/src/features/weather/domain/weather_data.dart';
import 'package:task_weather_app/src/features/weather/repository/weather_repository.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Should return weather data for successful HTTP call', () async {
    final MockClient mockClient = MockClient();
    final WeatherRepository weatherRepository = WeatherRepository();

    final jsonResponse = {
      'current': {
        'temperature_2m': 15.0,
        'wind_speed_10m': 12.2,
      }
    };

    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(jsonEncode(jsonResponse), 200));

    final WeatherModel weatherData =
        await weatherRepository.fetchWeatherData("Berlin", mockClient);

    expect(weatherData.temperature, 15.0);
    expect(weatherData.windSpeed, 12.2);
  });

  test('Should throw exception for failed HTTP call', () async {
    final MockClient mockClient = MockClient();
    final WeatherRepository weatherRepository = WeatherRepository();

    when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response('Failed to load weather data', 404));

    await expectLater(
      weatherRepository.fetchWeatherData("Berlin", mockClient),
      throwsA(isInstanceOf<Exception>()),
    );
  });
}
