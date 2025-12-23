class Task {
  final String id;
  String title;
  String description;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'completed': completed,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    completed: json['completed'],
  );
}
