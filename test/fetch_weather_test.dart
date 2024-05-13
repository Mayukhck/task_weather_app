import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/data/weather_data.dart';
import 'package:task_weather_app/repository/weather_repo.dart';

import 'fetch_weather_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Should return weather data for successful HTTP call', () async {
    final MockClient mockClient = MockClient();

    final WeatherRepository weatherRepository = WeatherRepository();

    final jsonResponse = {
      'current': {
        'temperature_2m': 20.1,
        'wind_speed_10m': 11.7,
      }
    };

    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(jsonEncode(jsonResponse), 200));

    final WeatherData weatherData =
        await weatherRepository.fetchWeatherData("Berlin", mockClient);

    expect(weatherData.temperature, 20.1);
    expect(weatherData.windSpeed, 11.7);
  });

  test('Should throw exception for failed HTTP call', () async {
    final MockClient mockClient = MockClient();

    final WeatherRepository weatherRepository = WeatherRepository();

    when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response('Failed to load weather data', 404));

    expect(
        () async =>
            await weatherRepository.fetchWeatherData("Berlin", mockClient),
        throwsA(isInstanceOf<Exception>()));
  });
}
