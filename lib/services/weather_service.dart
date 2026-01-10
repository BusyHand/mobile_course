import 'dart:convert';

import 'package:flutter/services.dart';

import '../clients/weather_client.dart';
import '../models/city.dart';
import '../models/weather_condition.dart';
import '../models/weather_response.dart';

class WeatherService {
  final WeatherClient _client = WeatherClient();
  Map<String, WeatherCondition> _weatherConditions = {};

  WeatherService() {
    _loadWeatherConditions();
  }

  Future<void> _loadWeatherConditions() async {
    try {
      print('🔄 Loading weather conditions from assets/weather_codes.json');

      // Путь к файлу в lib/assets
      final String jsonString = await rootBundle.loadString(
        'assets/weather_codes.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      print(
        '✅ JSON loaded successfully! Found ${jsonMap.length} weather codes',
      );

      _weatherConditions = jsonMap.map((key, value) {
        return MapEntry(key, WeatherCondition.fromJson(value));
      });

      print('✅ Weather conditions loaded successfully');
      print('📊 Available codes: ${_weatherConditions.keys.toList()}');
    } catch (e, stackTrace) {
      print('❌ ERROR loading weather conditions: $e');
      print('📋 Stack trace: $stackTrace');
    }
  }

  WeatherCondition? getWeatherCondition(int code) {
    return _weatherConditions[code.toString()];
  }

  Future<WeatherResponse> getWeatherForecast(
    double latitude,
    double longitude,
  ) async {
    final data = await _client.fetchWeatherData(latitude, longitude);
    return WeatherResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> getCurrentWeatherData(
    double latitude,
    double longitude,
  ) async {
    return await _client.getCurrentWeather(latitude, longitude);
  }

  static final List<City> availableCities = [
    City(name: 'Москва', latitude: 55.7558, longitude: 37.6173),
    City(name: 'Санкт-Петербург', latitude: 59.9343, longitude: 30.3351),
    City(name: 'Екатеринбург', latitude: 56.8389, longitude: 60.6057),
    City(name: 'Новосибирск', latitude: 55.0084, longitude: 82.9357),
    City(name: 'Казань', latitude: 55.7963, longitude: 49.1088),
    City(name: 'Сочи', latitude: 43.5855, longitude: 39.7231),
    City(name: 'Владивосток', latitude: 43.1155, longitude: 131.8855),
  ];
}
