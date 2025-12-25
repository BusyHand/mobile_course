import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/calendar_controller.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/calendar_header.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalendarController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Календарь')),
      body: Column(
        children: [
          CalendarHeader(controller: controller),
          CalendarGrid(model: controller.model),
          if (!controller.isCurrentMonth)
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: ElevatedButton(
                onPressed: controller.goToToday,
                child: const Text('Вернуться к текущему месяцу'),
              ),
            ),
        ],
      ),
    );
  }
}
