class WeatherCondition {
  final String dayDescription;
  final String dayImage;
  final String nightDescription;
  final String nightImage;

  WeatherCondition({
    required this.dayDescription,
    required this.dayImage,
    required this.nightDescription,
    required this.nightImage,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      dayDescription: json['day']['description'],
      dayImage: json['day']['image'],
      nightDescription: json['night']['description'],
      nightImage: json['night']['image'],
    );
  }
}
