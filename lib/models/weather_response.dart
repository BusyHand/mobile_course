import 'daily_weather.dart';

class WeatherResponse {
  final double latitude;
  final double longitude;
  final DailyWeather daily;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      daily: DailyWeather.fromJson(json['daily']),
    );
  }
}
