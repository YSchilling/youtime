class Todo {
  final int id;
  final String title;
  final bool done;

  Todo({required this.id, required this.title, required this.done});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, done: $done)';
  }
}
