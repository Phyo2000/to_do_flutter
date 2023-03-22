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

  // DateTime dateTime = DateTime.now();

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

  // void _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   ).then((value) {
  //     setState(() {
  //       dateTime = value!;
  //     });
  //   });
  // }

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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.abc,
                  color: Colors.deepPurple,
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
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    "Select Date",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(1980),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (newDate == null) return;
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () => addNewTodo(context: context),
                  child: const Text("Add")),
            ),
          ],
        ),
      ),
    );
  }
}
