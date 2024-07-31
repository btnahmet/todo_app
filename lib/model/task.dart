enum TaskType { note, calender, contest }

class Task {
  int id;
  String title;
  String description;
  bool isCompleted;
   String dueDate;
  TaskType type;

  Task({
    required this.id,
    required this.title,
    required this.description,
     required this.dueDate,
    required this.isCompleted,
    required this.type,
  });

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'is_completed': isCompleted ? 1 : 0,
      'type': type.toString().split('.').last, // Save TaskType as String
    };
  }

  // Extract a Task object from a Map.
factory Task.fromMap(Map<String, dynamic> map) {
  return Task(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    dueDate: map['dueDate'], // dueDate parametresini ekleyin
    isCompleted: map['is_completed'] == 1,
    type: TaskType.values.firstWhere((e) => e.toString().split('.').last == map['type']),
  );
}
}

