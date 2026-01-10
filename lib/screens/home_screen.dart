import 'package:flutter/material.dart';

import '../models/city.dart';
import '../models/weather_response.dart';
import '../services/weather_service.dart';
import '../widgets/city_selector.dart';
import '../widgets/forecast_list.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  City _selectedCity = WeatherService.availableCities[0];
  WeatherResponse? _weatherData;
  Map<String, dynamic>? _currentWeather;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final current = await _weatherService.getCurrentWeatherData(
        _selectedCity.latitude,
        _selectedCity.longitude,
      );
      final forecast = await _weatherService.getWeatherForecast(
        _selectedCity.latitude,
        _selectedCity.longitude,
      );

      setState(() {
        _currentWeather = current;
        _weatherData = forecast;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error loading weather data: $e');
    }
  }

  void _onCitySelected(City city) {
    setState(() {
      _selectedCity = city;
    });
    _loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Прогноз Погоды'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWeatherData,
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => CitySelector(
              cities: WeatherService.availableCities,
              selectedCity: _selectedCity,
              onCitySelected: _onCitySelected,
            ),
          );
        },
        child: Icon(Icons.location_city, color: isDark ? Colors.white : Colors.blue),
        backgroundColor: isDark ? Colors.grey[800] : Colors.blue[50],
      ),
    );
  }

  Widget _buildBody() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: isDark ? Colors.blue[200] : Colors.blue,
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: isDark ? Colors.red[300] : Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Ошибка загрузки данных',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWeatherData,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.blue[800] : Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    if (_currentWeather == null || _weatherData == null) {
      return Center(
        child: Text(
          'Нет данных о погоде',
          style: TextStyle(
            fontSize: 18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadWeatherData,
      color: isDark ? Colors.blue[200] : Colors.blue,
      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Текущая погода
              CurrentWeatherCard(
                city: _selectedCity,
                currentWeather: _currentWeather!,
                weatherService: _weatherService,
              ),
              const SizedBox(height: 24),
              // Прогноз на 7 дней
              ForecastList(
                dailyItems: _weatherData!.daily.dailyItems,
                weatherService: _weatherService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}