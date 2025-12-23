import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task? task;

  const EditTaskScreen({super.key, this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController title;
  late TextEditingController desc;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.task?.title ?? '');
    desc = TextEditingController(text: widget.task?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final service = context.read<TaskService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Задача'),
        actions: widget.task != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    service.delete(widget.task!.id);
                    Navigator.pop(context);
                  },
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: desc,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.task == null) {
                  service.add(title.text, desc.text);
                } else {
                  widget.task!
                    ..title = title.text
                    ..description = desc.text;
                  service.update(widget.task!);
                }
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
