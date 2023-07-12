import 'package:app/provider/todo_list_notifier.dart';
import 'package:flutter/material.dart';

class CreateTodoButton extends StatelessWidget {
  const CreateTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
          context: context, builder: (context) => const CreateTodoSheet()),
      child: const Icon(Icons.add),
    );
  }
}

class CreateTodoSheet extends StatefulWidget {
  const CreateTodoSheet({super.key});

  @override
  State<CreateTodoSheet> createState() => _CreateTodoSheetState();
}

class _CreateTodoSheetState extends State<CreateTodoSheet> {
  final _textController = TextEditingController();
  String errMsg = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textController,
          onChanged: (value) => setState(() {
            errMsg = "";
          }),
        ),
        Text(errMsg),
        TextButton(
          onPressed: () {
            setState(() {
              if (_textController.text == "") {
                errMsg = "Can't be empty!";
                return;
              }

              TodoListNotifier().addTodo(_textController.text, false);
              _textController.text = "";
              Navigator.pop(context);
            });
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
