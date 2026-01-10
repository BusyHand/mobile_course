import 'package:flutter/material.dart';

import '../models/city.dart';
import '../services/weather_service.dart';

class CurrentWeatherCard extends StatelessWidget {
  final City city;
  final Map<String, dynamic> currentWeather;
  final WeatherService weatherService;

  const CurrentWeatherCard({
    super.key,
    required this.city,
    required this.currentWeather,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final current = currentWeather['current'];
    final isDay = current['is_day'] == 1;
    final weatherCode = current['weather_code'];
    final condition = weatherService.getWeatherCondition(weatherCode);

    return Card(
      elevation: 4,
      color: isDark ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Сегодня',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (condition != null)
                  Column(
                    children: [
                      Image.network(
                        isDay ? condition.dayImage : condition.nightImage,
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            isDay ? Icons.wb_sunny : Icons.nightlight_round,
                            size: 60,
                            color: isDark ? Colors.amber[200] : Colors.amber,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isDay
                            ? condition.dayDescription
                            : condition.nightDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(
                  'Температура',
                  '${current['temperature_2m'].toStringAsFixed(1)}°C',
                  Icons.thermostat,
                  isDark ? Colors.red[300]! : Colors.red,
                  isDark,
                ),
                _buildWeatherInfo(
                  'Влажность',
                  '${current['relative_humidity_2m']}%',
                  Icons.water_drop,
                  isDark ? Colors.blue[300]! : Colors.blue,
                  isDark,
                ),
                _buildWeatherInfo(
                  'Ветер',
                  '${current['wind_speed_10m'].toStringAsFixed(1)} м/с',
                  Icons.air,
                  isDark ? Colors.green[300]! : Colors.green,
                  isDark,
                ),
                _buildWeatherInfo(
                  'Давление',
                  '${current['surface_pressure'].toStringAsFixed(0)} гПа',
                  Icons.speed,
                  isDark ? Colors.orange[300]! : Colors.orange,
                  isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
      String label,
      String value,
      IconData icon,
      Color color,
      bool isDark,
      ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}