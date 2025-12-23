import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/task_service.dart';
import '../widgets/task_tile.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<TaskService>();
    final tasks = service.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          DropdownButton<TaskFilter>(
            value: service.filter,
            onChanged: service.changeFilter,
            items: const [
              DropdownMenuItem(
                value: TaskFilter.active,
                child: Text('Текущие'),
              ),
              DropdownMenuItem(
                value: TaskFilter.completed,
                child: Text('Выполненные'),
              ),
            ],
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Нет запланированных задач'))
          : ListView(children: tasks.map((t) => TaskTile(task: t)).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditTaskScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
