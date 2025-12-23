import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';

enum TaskFilter { active, completed }

class TaskService extends ChangeNotifier {
  final TaskRepository repository;
  TaskFilter filter = TaskFilter.active;

  TaskService(this.repository);

  Future<void> init() async {
    await repository.load();
    notifyListeners();
  }

  List<Task> get tasks {
    return repository.tasks.values
        .where((t) => filter == TaskFilter.active ? !t.completed : t.completed)
        .toList();
  }

  void add(String title, String description) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    repository.add(task);
    repository.save();
    notifyListeners();
  }

  void toggle(Task task) {
    task.completed = !task.completed;
    repository.update(task);
    repository.save();
    notifyListeners();
  }

  void update(Task task) {
    repository.update(task);
    repository.save();
    notifyListeners();
  }

  void delete(String id) {
    repository.remove(id);
    repository.save();
    notifyListeners();
  }

  void changeFilter(TaskFilter? value) {
    if (value == null) return;
    filter = value;
    notifyListeners();
  }

}
