import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_weather_app/screens/home_screen.dart';


void main() {

  testWidgets('Finding title present in screen or not',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProviderScope(
          child: MyHomePage(),
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
          child: MyHomePage(),
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
          child: MyHomePage(),
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
          child: MyHomePage(),
        ),
      ),
    );

    final fetchButtonFinder = find.byType(ElevatedButton);

    await tester.tap(fetchButtonFinder);
    await tester.pumpAndSettle();

    final temperatureFinder = find.text(' ');
    expect(temperatureFinder, findsNothing);
  });
}
