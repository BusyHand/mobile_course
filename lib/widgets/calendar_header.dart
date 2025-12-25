import 'package:flutter/material.dart';

import '../controllers/calendar_controller.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarController controller;

  const CalendarHeader({super.key, required this.controller});

  void _showYearPicker(BuildContext context) {
    final controller = this.controller;

    showDialog(
      context: context,
      builder: (context) {
        int tempYear = controller.model.year;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Выбор года'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        tempYear--;
                      });
                    },
                  ),
                  Text(
                    tempYear.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        tempYear++;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.setYear(tempYear);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildWeekDays() {
    const weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    return Row(
      children: weekDays.map((day) {
        final isWeekend = day == 'Сб' || day == 'Вс';

        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isWeekend ? Colors.redAccent : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }


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

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: controller.prevMonth,
                ),
                Column(
                  children: [
                    Text(monthName, style: const TextStyle(fontSize: 18)),
                    GestureDetector(
                      onTap: () => _showYearPicker(context),
                      child: Text(
                        controller.model.year.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: controller.nextMonth,
                ),
              ],
            ),

            const SizedBox(height: 8),

            _buildWeekDays(),

            const Divider(height: 16),
          ],
        ),
      ),
    );
  }

}
