import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_weather_app/src/features/weather/provider/weather_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String defaultCityName = 'Berlin';

    return Scaffold(
      appBar: AppBar(
        key: const ValueKey('home_title'),
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(weatherStateNotifierProvider.notifier)
                      .fetchWeather(defaultCityName);
                },
                child: const Text('Fetch Weather'),
              ),
              const SizedBox(height: 50),
              const Text(
                'City: $defaultCityName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Consumer(
                builder: (context, ref, _) {
                  final weatherState = ref.watch(weatherStateNotifierProvider);

                  return weatherState.when(
                    data: (weatherData) => Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Temperature: ${weatherData.temperature}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                    loading: () => const CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
