import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/src/features/weather/domain/weather_data.dart';
import 'package:task_weather_app/src/features/weather/repository/weather_repository.dart';
import 'package:task_weather_app/src/features/weather/presentation/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  group('Checking widget found or not', () {
    testWidgets('Finding title present in screen or not',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: HomeView(),
          ),
        ),
      );

      Finder title = find.byKey(const ValueKey('home_title'));

      expect(title, findsOneWidget);
    });

    testWidgets('Finding button present in screen or not',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: HomeView(),
          ),
        ),
      );

      Finder button = find.byType(ElevatedButton);

      expect(button, findsOneWidget);
    });

    testWidgets('Finding city name present in screen or not',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: HomeView(),
          ),
        ),
      );

      Finder city = find.text('City: Berlin');

      expect(city, findsOneWidget);
    });

    testWidgets('Pressing button should not get error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: HomeView(),
          ),
        ),
      );

      final fetchButtonFinder = find.byType(ElevatedButton);

      await tester.tap(fetchButtonFinder);
      await tester.pumpAndSettle();

      final temperatureFinder = find.text(' ');
      expect(temperatureFinder, findsNothing);
    });
  });
  group('When button pressed data will fetch or not', () {
    late MockWeatherRepository mockWeatherRepository;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
    });

    testWidgets('fetches and displays temperature',
        (WidgetTester tester) async {
      final mockWeatherData = WeatherModel(temperature: 15.0);

      when(mockWeatherRepository.fetchWeatherData(any, any))
          .thenAnswer((_) async => mockWeatherData);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          ],
          child: const MaterialApp(
            home: HomeView(),
          ),
        ),
      );

      final fetchButtonFinder = find.byType(ElevatedButton);

      await tester.tap(fetchButtonFinder);
      await tester.pumpAndSettle();

      final temperatureText = find.text('Temperature: 15.0');

      expect(temperatureText, findsOneWidget);
    });
  });
}
