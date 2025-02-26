import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
