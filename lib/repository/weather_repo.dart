import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_weather_app/data/weather_data.dart';

class WeatherRepository {
  final String baseURL = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherData> fetchWeatherData(String cityName,http.Client client) async {
    final Uri url = Uri.parse('$baseURL?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final currentData = jsonData['current'];
      return WeatherData.fromJson(currentData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}