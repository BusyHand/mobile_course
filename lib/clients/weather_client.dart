import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherClient {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> fetchWeatherData(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl?latitude=$latitude&longitude=$longitude'
                '&daily=weather_code,temperature_2m_max,temperature_2m_min'
                '&timezone=auto'
                '&current=temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m,surface_pressure'
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  Future<Map<String, dynamic>> getCurrentWeather(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl?latitude=$latitude&longitude=$longitude'
                '&current=temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m,surface_pressure,is_day'
                '&timezone=auto'
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load current weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load current weather: $e');
    }
  }
}