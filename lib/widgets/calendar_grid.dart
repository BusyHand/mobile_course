import 'package:flutter/material.dart';

import '../models/calendar_model.dart';
import 'day_cell.dart';

class CalendarGrid extends StatelessWidget {
  final CalendarModel model;

  const CalendarGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final days = <Widget>[];

    for (int i = 1; i < model.firstWeekday; i++) {
      days.add(const SizedBox());
    }

    for (int day = 1; day <= model.daysInMonth; day++) {
      days.add(DayCell(day: day, isToday: model.isToday(day)));
    }

    return Expanded(child: GridView.count(crossAxisCount: 7, children: days));
  }
}
