import 'package:riverpod/riverpod.dart';
import 'package:task_weather_app/data/weather_data.dart';
import 'package:task_weather_app/repository/weather_repo.dart';
import 'package:http/http.dart' as http;

final weatherRepositoryProvider = Provider((ref) => WeatherRepository());

final weatherFutureProvider = FutureProvider.autoDispose
    .family<WeatherData, String>((ref, cityName) async {
  final repository = ref.read(weatherRepositoryProvider);
  return repository.fetchWeatherData(cityName, http.Client());
});

class WeatherStateNotifier extends StateNotifier<AsyncValue<WeatherData>> {
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
    WeatherStateNotifier, AsyncValue<WeatherData>>(
  (ref) => WeatherStateNotifier(ref.watch(weatherRepositoryProvider)),
);
