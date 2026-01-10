import 'daily_weather_item.dart';

class DailyWeather {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperatureMax;
  final List<double> temperatureMin;

  DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.temperatureMax,
    required this.temperatureMin,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<String>.from(json['time'] ?? []),
      weatherCode: List<int>.from(
        json['weather_code']?.map((x) => x?.toInt() ?? 0) ?? [],
      ),
      temperatureMax: List<double>.from(
        json['temperature_2m_max']?.map((x) => x?.toDouble() ?? 0.0) ?? [],
      ),
      temperatureMin: List<double>.from(
        json['temperature_2m_min']?.map((x) => x?.toDouble() ?? 0.0) ?? [],
      ),
    );
  }

  List<DailyWeatherItem> get dailyItems {
    List<DailyWeatherItem> items = [];
    for (int i = 0; i < time.length; i++) {
      items.add(
        DailyWeatherItem(
          date: time[i],
          weatherCode: weatherCode[i],
          maxTemp: temperatureMax[i],
          minTemp: temperatureMin[i],
        ),
      );
    }
    return items;
  }
}
