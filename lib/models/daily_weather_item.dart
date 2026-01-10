class DailyWeatherItem {
  final String date;
  final int weatherCode;
  final double maxTemp;
  final double minTemp;
  final DateTime dateTime;

  DailyWeatherItem({
    required this.date,
    required this.weatherCode,
    required this.maxTemp,
    required this.minTemp,
  }) : dateTime = DateTime.parse(date);

  String get dayOfWeek {
    const days = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
    return days[dateTime.weekday % 7];
  }
}
