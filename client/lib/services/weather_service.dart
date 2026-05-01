import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherInfo {
  final double temp;
  final String condition;
  final String icon;

  WeatherInfo({
    required this.temp,
    required this.condition,
    required this.icon,
  });
}

class WeatherService {
  // Replace with actual API key when integrating
  static const String _apiKey = "DEMO_MODE";

  Future<WeatherInfo?> fetch(String city) async {
    // Demo mode - return simulated data
    if (_apiKey == "DEMO_MODE") {
      await Future.delayed(Duration(milliseconds: 100));
      return WeatherInfo(
        temp: 72.0,
        condition: 'Clear',
        icon: '01d',
      );
    }

    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=imperial";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) return null;

      final data = jsonDecode(res.body);

      return WeatherInfo(
        temp: data["main"]["temp"]?.toDouble() ?? 0.0,
        condition: data["weather"][0]["main"] ?? "Unknown",
        icon: data["weather"][0]["icon"] ?? "",
      );
    } catch (_) {
      return null;
    }
  }
}
