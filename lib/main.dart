import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/calendar_controller.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarController(),
      child: MaterialApp(
        title: 'Calendar',
        theme: ThemeData(useMaterial3: true),
        home: const CalendarScreen(),
      ),
    );
  }
}
