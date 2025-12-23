class CalendarModel {
  final int year;
  final int month;

  CalendarModel({required this.year, required this.month});

  DateTime get firstDay => DateTime(year, month, 1);

  int get daysInMonth => DateTime(year, month + 1, 0).day;

  int get firstWeekday => firstDay.weekday; // 1..7 (Mon..Sun)

  bool isToday(int day) {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
}
