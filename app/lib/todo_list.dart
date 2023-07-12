import 'package:app/provider/todo_list_notifier.dart';
import 'package:app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListNotifier>(
      builder: (context, value, child) => FutureBuilder(
        future: TodoListNotifier().getTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  TodoTile(todo: snapshot.data![index]),
            );
          }
        },
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: todo.done,
            onChanged: (value) {
              Todo newTodo = Todo(id: todo.id, title: todo.title, done: value!);
              TodoListNotifier().updateTodo(newTodo);
            },
          ),
          IconButton(
            onPressed: () => TodoListNotifier().removeTodo(todo.id),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
