import 'package:app/create_todo.dart';
import 'package:app/provider/todo_list_notifier.dart';
import 'package:app/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => TodoListNotifier(),
        child: const Scaffold(
          body: TodoList(),
          floatingActionButton: CreateTodoButton(),
        ),
      ),
    );
  }
}
