import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override

//api key
  final _weatherService = WeatherService('d5a75696eacc932b675531537ab3d1fe');
  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //initState
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    //weather animations
    String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'assets/Sunny.json';

      switch (mainCondition.toLowerCase()) {
        case 'fog':
          return 'assets/Cloudy.json';
        case 'shower rain':
          return 'assets/Raining.json';
        case 'thunderstorm':
          return 'assets/Thunder.json';
        case 'clear':
          return 'assets/Sunny.json';
        default:
          return 'assets/Sunny.json';
      }
    }

    Color getBackgroundColors(String? mainCondition) {
      if (mainCondition == null) return Colors.white;

      switch (mainCondition.toLowerCase()) {
        case 'fog':
          return Colors.grey;
        case 'shower rain':
          return Colors.grey;
        case 'thunderstorm':
          return Colors.grey;
        case 'clear':
          return Colors.white;
        default:
          return Colors.white;
      }
    }

    return Scaffold(
      backgroundColor: getBackgroundColors(_weather?.mainCondition),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.mapPin,
              size: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _weather?.cityName ?? "Loading City",
              style: GoogleFonts.anton(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            ),
            Text(
              '${_weather?.temperature.round()}°C',
              style: GoogleFonts.anton(fontSize: 50),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: GoogleFonts.anton(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
