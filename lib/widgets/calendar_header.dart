import 'package:flutter/material.dart';

import '../controllers/calendar_controller.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarController controller;

  const CalendarHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final monthName = [
      '',
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ][controller.model.month];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: controller.prevMonth,
        ),
        Column(
          children: [
            Text(monthName, style: const TextStyle(fontSize: 18)),
            Text(controller.model.year.toString()),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: controller.nextMonth,
        ),
      ],
    );
  }
}
