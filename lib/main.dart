import 'package:flutter/material.dart';
import 'package:mobile_course/repositories/task_repository.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/task_service.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskService(TaskRepository())..init(),
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
