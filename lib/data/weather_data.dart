
class WeatherData {
  final String? time;
  final double temperature;
  final double? windSpeed;

  WeatherData({
    this.time,
    required this.temperature,
    this.windSpeed,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: json['time'],
      temperature: json['temperature_2m'].toDouble(),
      windSpeed: json['wind_speed_10m'].toDouble(),
    );
  }
}
