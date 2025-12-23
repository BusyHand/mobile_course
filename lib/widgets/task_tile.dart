import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final service = context.read<TaskService>();

    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.completed,
        onChanged: (_) => service.toggle(task),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
      ),
    );
  }
}
