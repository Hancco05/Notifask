class Task {
  final int? id;
  final String name;
  final String description;
  final String date;
  final String importance;
  final bool isPending;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.importance,
    this.isPending = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'importance': importance,
      'isPending': isPending ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      date: map['date'],
      importance: map['importance'],
      isPending: map['isPending'] == 1,
    );
  }
}
