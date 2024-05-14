import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_weather_app/screens/home_screen.dart';

void main() {
  group('Button flow', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Pressing button should not get error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: MyHomePage(),
          ),
        ),
      );

      final fetchButtonFinder = find.byType(ElevatedButton);

      await tester.tap(fetchButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final temperatureFinder = find.text(' ');
      expect(temperatureFinder, findsNothing);
    });
  });
}
