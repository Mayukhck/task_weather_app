
class WeatherModel {
  final String? time;
  final double temperature;
  final double? windSpeed;

  WeatherModel({
    this.time,
    required this.temperature,
    this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json['time'],
      temperature: json['temperature_2m'].toDouble(),
      windSpeed: json['wind_speed_10m'].toDouble(),
    );
  }
}
