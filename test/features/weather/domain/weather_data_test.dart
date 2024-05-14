import 'package:flutter_test/flutter_test.dart';
import 'package:task_weather_app/features/weather/domain/weather_data.dart';

void main() {
  group('WeatherModel', () {
    test('fromJson should correctly parse JSON with all fields', () {
      final json = {
        'time': '2024-05-14T12:00:00',
        'temperature_2m': 25.0,
        'wind_speed_10m': 10.0,
      };

      final weatherModel = WeatherModel.fromJson(json);

      expect(weatherModel.time, '2024-05-14T12:00:00');
      expect(weatherModel.temperature, 25.0);
      expect(weatherModel.windSpeed, 10.0);
    });

    test('fromJson should correctly parse JSON with missing optional fields',
        () {
      final json = {
        'time': '2024-05-14T12:00:00',
        'temperature_2m': 25.0,
      };

      final weatherModel = WeatherModel.fromJson(json);

      expect(weatherModel.time, '2024-05-14T12:00:00');
      expect(weatherModel.temperature, 25.0);
      expect(weatherModel.windSpeed, isNull);
    });

    test('fromJson should throw ArgumentError if required field is missing',
        () {
      final json = {
        'temperature_2m': 25.0,
        'wind_speed_10m': 10.0,
      };

      expect(() => WeatherModel.fromJson(json), throwsArgumentError);
    });
  });
}
