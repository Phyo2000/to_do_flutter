import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoAddScreen extends StatefulWidget {
  static String name = "/todo_add_screen";

  final TodoItem? item;

  const TodoAddScreen({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final titleController = TextEditingController();

  final descController = TextEditingController();

  void addNewTodo({required BuildContext context}) {
    final provider = Provider.of<ListTodoItem>(context, listen: false);

    provider.addTodoItem(
      item: TodoItem(
        id: Random.secure().nextInt(2),
        description: descController.text,
        icon: Icons.home,
        title: titleController.text,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.item?.title ?? "";
    descController.text = widget.item?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // final arguments =
    //     ModalRoute.of(context)!.settings.arguments as List<TodoItem>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your ToDo Activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.key,
                  color: Colors.red,
                ),
                // prefix: Icon(
                //   Icons.key,
                //   color: Colors.red,
                // ),
              ),
              onChanged: (value) {
                debugPrint(
                    "----------------------$value----------------------");
              },
            ),
            ElevatedButton(
                onPressed: () => addNewTodo(context: context),
                child: const Text("button")),
          ],
        ),
      ),
    );
  }
}
