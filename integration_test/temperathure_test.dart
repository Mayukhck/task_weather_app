import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_weather_app/data/weather_data.dart';
import 'package:task_weather_app/provi/weather_proviser.dart';
import 'package:task_weather_app/repository/weather_repo.dart';
import 'package:task_weather_app/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../test/home_page_temperathure_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  group('MyHomePage', () {
    late MockWeatherRepository mockWeatherRepository;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
    });

    testWidgets('fetches and displays temperature',
      (WidgetTester tester) async {
        final mockWeatherData = WeatherData(temperature: 25.0);
        when(mockWeatherRepository.fetchWeatherData(any, any))
          .thenAnswer((_) => Future.value(mockWeatherData));

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              weatherRepositoryProvider.overrideWith(
                (ref) => mockWeatherRepository as WeatherRepository,
              ),
            ],
            child: const MyHomePage(),
          ),
        );

        final fetchButton = find.text('Fetch Weather');

        await tester.tap(fetchButton);
        await tester.pump();

        final temperatureText = find.text('Temperature: 25.0');

        expect(temperatureText, findsOneWidget);
      });
  });
}
