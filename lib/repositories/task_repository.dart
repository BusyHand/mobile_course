import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskRepository {
  static const _storageKey = 'tasks';

  final Map<String, Task> _tasks = {};

  Map<String, Task> get tasks => _tasks;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return;

    final List decoded = jsonDecode(jsonString);
    for (var item in decoded) {
      final task = Task.fromJson(item);
      _tasks[task.id] = task;
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _tasks.values.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(list));
  }

  void add(Task task) {
    _tasks[task.id] = task;
  }

  void update(Task task) {
    _tasks[task.id] = task;
  }

  void remove(String id) {
    _tasks.remove(id);
  }
}
