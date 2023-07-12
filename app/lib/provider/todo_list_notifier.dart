import 'package:app/models/database.dart';
import 'package:app/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoListNotifier extends ChangeNotifier {
  static final TodoListNotifier _singleton = TodoListNotifier._internal();

  factory TodoListNotifier() {
    return _singleton;
  }

  TodoListNotifier._internal();

  addTodo(String title, bool done) async {
    await SQLHelper.insertTodo(title, done);
    notifyListeners();
  }

  Future<List<Todo>> getTodos() async {
    return await SQLHelper.getTodos();
  }

  updateTodo(Todo todo) async {
    await SQLHelper.updateTodo(todo);
    notifyListeners();
  }

  removeTodo(int id) async {
    await SQLHelper.deleteTodo(id);
    notifyListeners();
  }
}
