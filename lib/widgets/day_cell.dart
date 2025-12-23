import 'package:flutter/material.dart';

class DayCell extends StatelessWidget {
  final int day;
  final bool isToday;

  const DayCell({super.key, required this.day, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? Colors.blue : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            color: isToday ? Colors.white : Colors.black,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
