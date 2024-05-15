import 'package:riverpod/riverpod.dart';
import 'package:task_weather_app/src/features/weather/domain/weather_data.dart';
import 'package:task_weather_app/src/features/weather/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

class WeatherStateNotifier extends StateNotifier<AsyncValue<WeatherModel>> {
  final WeatherRepository repository;

  WeatherStateNotifier(this.repository) : super(const AsyncLoading());

  Future<void> fetchWeather(String cityName) async {
    state = const AsyncLoading();
    try {
      final weatherData =
          await repository.fetchWeatherData(cityName, http.Client());
      state = AsyncData(weatherData);
    } catch (error, st) {
      state = AsyncError(error, st);
    }
  }
}

final weatherStateNotifierProvider = StateNotifierProvider.autoDispose<
    WeatherStateNotifier, AsyncValue<WeatherModel>>(
  (ref) => WeatherStateNotifier(ref.watch(weatherRepositoryProvider)),
);
