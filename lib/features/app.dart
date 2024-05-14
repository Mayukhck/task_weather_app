import 'package:flutter/material.dart';
import 'package:task_weather_app/features/weather/presentation/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}