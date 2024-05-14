
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
  if (json['temperature_2m'] == null) {
    throw const FormatException("Missing required field: temperature_2m");
  }
  return WeatherModel(
    time: json['time'],
    temperature: json['temperature_2m'],
    windSpeed: json['wind_speed_10m'],
  );
}
}
