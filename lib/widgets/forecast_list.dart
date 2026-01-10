import 'package:flutter/material.dart';

import '../models/daily_weather_item.dart';
import '../services/weather_service.dart';

class ForecastList extends StatelessWidget {
  final List<DailyWeatherItem> dailyItems;
  final WeatherService weatherService;

  const ForecastList({
    super.key,
    required this.dailyItems,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Прогноз на 7 дней',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...dailyItems.map((day) => _buildForecastItem(day, isDark)).toList(),
      ],
    );
  }

  Widget _buildForecastItem(DailyWeatherItem day, bool isDark) {
    final condition = weatherService.getWeatherCondition(day.weatherCode);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? Colors.grey[900] : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // День недели (фиксированная ширина)
              SizedBox(
                width: 50,
                child: Text(
                  day.dayOfWeek,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              // Иконка погоды (фиксированная ширина)
              if (condition != null)
                SizedBox(
                  width: 60,
                  child: Center(
                    child: Image.network(
                      condition.dayImage,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.wb_sunny,
                          size: 30,
                          color: isDark ? Colors.amber[200] : Colors.amber,
                        );
                      },
                    ),
                  ),
                ),

              // Описание погоды (растягивается)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    condition?.dayDescription ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ),
              ),

              // Температура (фиксированная ширина)
              SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${day.maxTemp.toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.red[300] : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/${day.minTemp.toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.blue[300] : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}